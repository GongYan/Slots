local Utils = cc.exports.Utils
local NetWork = class("NetWork")


local scheduler = cc.Director:getInstance():getScheduler() 

function NetWork:ctor()
	self.isNetConnected = false --网络是否已链接
	self.sendTaskList = {}
	self.msgSize = 2 --包体总长度字节数
	self.remainRecvSize = 2
	self.recvingBuffer = ""
	self.recvState = "Head"
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

function NetWork:send(msgName, msgBody)
	dump(msgBody, msgName)
	--拼装
	local msgHead = {msgtype = 1, msgname = msgName, msgret = 0}
	local pbHead = protobuf.encode("PbHead.MsgHead", msgHead)
	local pbBody = protobuf.encode(msgName, msgBody)

	local headPack = string.pack(">P", pbHead)
	local bodyPack = string.pack(">P", pbBody)
	local msgLen = string.len(headPack) + string.len(bodyPack)
	local lenPack = string.pack(">H", msgLen)
	Utils.log("GameNet send msg:"..msgName .. ": headPackLen:" .. #headPack .. ": bodyPackLen: " .. #bodyPack)
	local data = lenPack .. headPack ..bodyPack
	table.insert(self.sendTaskList, 1, data)
end

function NetWork:receiveMessage(messageQueue)
	if self.remainRecvSize <= 0 then
		return true
	end

	local recvContent, errorInfo, otherContent = self.socket:receive(self.remainRecvSize)
	if errorInfo ~= nil then
		if errorInfo == "timeout" then --由于timeout为0并且为异步socket，不能认为socket出错
			if otherContent ~= nil and #otherContent > 0 then
				self.recvingBuffer = self.recvingBuffer .. otherContent
				self.remainRecvSize = self.remainRecvSize - #otherContent
				Utils.log("recv timeout, but had other content. size:" .. #otherContent)
			end
			return true
		else --发生错误，这个点可以考虑重连了，不用等待heartbeat
			Utils.log("recv failed errorinf: " .. errorInfo)
			return false
		end
	end

	local contentSize = #recvContent
	self.recvingBuffer = self.recvingBuffer .. recvContent
	self.remainRecvSize = self.remainRecvSize - contentSize

	if self.remainRecvSize > 0 then --等待下次接收
		return true
	end

	if self.recvState == "Head" then
		local first, second = string.byte(self.recvingBuffer, 1,2)
		self.remainRecvSize = first * 256 + second --通过位计算长度
		self.recvingBuffer = ""
		self.recvState = "Body"
	elseif self.recvState == "Body" then
		--解析包
		local pbLen, pbHead, pbBody = string.unpack(self.recvingBuffer, ">PP")
		local msgHead = protobuf.decode("PbHead.MsgHead", pbHead)
		local msgBody = protobuf.decode(msgHead.msgname, pbBody)
		Utils.log("收到服务器数据", msgHead.msgname)

		Utils.log("msgHead.msgtype " .. msgHead.msgtype .. "msgHead.msgname " ..msgHead.msgname .. "msgHead.msgret " ..msgHead.msgret)
		Utils.log("---pbLen " .. pbLen)
		Utils.log("msgBody.platform " .. msgBody.platform .. "msgBody.msgname " ..msgBody.user_id )
		Utils.log("---------end------------")

		self.remainRecvSize = self.msgSize
		self.recvingBuffer = ""
		self.recvState = "Head"
	end

	--继续接数据包 如果有大量网络包发送给客户端可能会有掉帧现象，但目前不需要考虑，解决方案可以1.设定总接收时间2.收完body包就不在继续接收了
	return self:receiveMessage(messageQueue)
end

function NetWork:processInput()
	--检测是否有可读的socket
	local recvt, sendt, status = socket.select({self.socket}, nil, 1)
	Utils.log("input select", #recvt, sendt, status)
	if #recvt <= 0 then
		return
	end

	local messageQueue = {}
	if not self:receiveMessage(messageQueue) then
		--重新登录
		return
	end

	if #messageQueue <= 0 then
		return
	end

	--分发数据出去

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




function NetWork:luaToCByShort(value)
	return string.char(value % 256) .. string.char(math.floor(value / 256))
end

function NetWork:luaToCByInt(value)
	local lowByte1 = string.char(math.floor(value / (256 * 256 * 256)))
	local lowByte2 = string.char(math.floor(value / (256 * 256)) % 256)
	local lowByte3 = string.char(math.floor(value / 256) % 256)
	local lowByte4 = string.char(value % 256)
	return lowByte4 .. lowByte3 .. lowByte2 .. lowByte1
end

return NetWork
