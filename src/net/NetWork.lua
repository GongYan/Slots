local Utils = cc.exports.Utils
local NetWork = class("NetWork")


local scheduler = cc.Director:getInstance():getScheduler() 

function NetWork:ctor()
	self.isNetConnected = false --网络是否已链接
	self.sendTaskList = {}
end

-- start --
--------------------------------
-- @class function
-- @description 和指定的ip/port服务器建立socket链接
-- @param ip 服务器ip地址
-- @param port 服务器端口号
-- @param isBlock 是否阻塞
-- @return socket链接创建是否成功
-- end --
function NetWork:connect(ip, port, isBlock)
	self.ip = ip
	self.port = port
	local socket, errorInfo = socket.tcp()
	if not socket then
		Utils.log(string.format("Connect failed when create socket | %s", errorInfo))
		return false
	end
	self.socket = socket
	
	self.socket:setoption("tcp-nodelay", true)  --去掉优化
	local connectCode, errorInfo = self.socket:connect(self.ip, self.port);    --链接

	if connectCode == 1 then
		self.socket:settimeout(isBlock and 8 or 0) 					--非阻塞
		Utils.log("socket connect success!" .. connectCode)
		self:createScheduler()
		return true
	else
		Utils.log(string.format("socket %s connect failed | %s", (isBlock and "Blocked" or ""), errorInfo) )
		return false
	end
end

function NetWork:createScheduler()
	local function checkConnect( dt )
		--停止定时器
		if self:isConnected() then
			self.isNetConnected = true
			scheduler:unscheduleScriptEntry(self.scheduler_id)

			self.precess_id = scheduler:scheduleScriptFunc(function ( ... )
				self:processSocketIO()
			end, 0.05, false)
		end
	end
	self.scheduler_id = scheduler:scheduleScriptFunc(checkConnect, 0.05, false)
end

-- start --
--------------------------------
-- @class function
-- @description 关闭socket链接
-- end --
function NetWork:close()
	if self.socket then
		self.socket:close()
	end

	if self.precess_id then
		scheduler:unscheduleScriptEntry(self.precess_id)
	end

	self.isNetConnected = false
end

function NetWork:isConnected()
	local forWrite = {}
	table.insert(forWrite, self.socket)
	local readyForWrite, _;
	_, readyForWrite,_ = socket.select(nil, forWrite, 0)
	if #readyForWrite > 0 then
		Utils.log(string.format("ready for write |  %s",#readyForWrite))
		return true
	end
	Utils.log("no ready for write")
	return false
end

function NetWork:processSocketIO()
	if not self.isNetConnected then
		return
	end
	self:processInput()
	self:processOutput()
end

function NetWork:processInput()
	--检测是否有可读的socket
	local recvt, sendt, status = socket.select({self.socket}, nil, 1)
	Utils.log("input", #recvt, sendt, status)
	if #recvt <= 0 then
		return
	end

	--先接收两个字节计算包长度
	local recvContent, errorInfo, otherContent = self.socket:receive(2)
	if recvContent then
		--计算包的长度
		local first, second = string.byte(recvContent, 1, 2)
		local len = first * 256 + second --通过位计算长度
		Utils.log("收到数据长度=",len)

		--接收整个数据
		local recvContent, errorInfo, otherContent = self.socket:receive(len)

		--解析包
		local pbLen, pbHead, pbBody, t = string.unpack(recvContent, ">PPb")
		local msgHead = protobuf.decode("PbHead.MsgHead", pbHead)
		local msgBody = protobuf.decode(msgHead.msgname, pbBody)
		Utils.log("收到服务器数据", msgHead.msgname)

		Utils.log("msgHead.msgtype " .. msgHead.msgtype .. "msgHead.msgname " ..msgHead.msgname .. "msgHead.msgret " ..msgHead.msgret)
		Utils.log("msgBody.platform " .. msgBody.platform .. "msgBody.msgname " ..msgBody.user_id )
	end
end

function NetWork:processOutput()
	if self.sendTaskList and #self.sendTaskList > 0 then
		local data = self.sendTaskList[#self.sendTaskList]
		if data then
			local _len, _error = self.socket:send(data)
			Utils.log("socket send"..#data, "_len:", _len, "error:", _error)
			--发送长度不为空， 并且发送长度==数据长度
			if _len and _len == #data then
				table.remove(self.sendTaskList, #self.sendTaskList)
			end
		end
	end
end


function NetWork:getInstance()
	if not self.instance then
		self.instance = NetWork:new()
	end
	return self.instance
end


function NetWork:send(msgName, msgBody)
	dump(msgBody, msgName)
	--拼装头
	local msgHead = {msgtype = 1, msgname = msgName, msgret = 0}
	local pbHead = protobuf.encode("PbHead.MsgHead", msgHead)
	local pbBody = protobuf.encode(msgName, msgBody)
	--计算长度
	local pbHeadLen = #pbHead
	local pbBodyLen = #pbBody
	local pbLen = 2 + pbHeadLen + 2 + pbBodyLen + 1

	local data = string.pack(">HPPb", pbLen, pbHead, pbBody, string.byte("t"))
	Utils.log("GameNet send msg:"..msgName..":"..string.char(string.byte('t')))
	table.insert(self.sendTaskList, 1, data)
end

return NetWork
