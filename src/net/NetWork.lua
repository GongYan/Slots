local NetWork = class("NetWork")


local scheduler = cc.Director:getInstance():getScheduler() 

function NetWork:ctor()
	self.isConnected_ = false
	self.sendTaskList = {}
end

function NetWork:connect(ip, port )
	self.ip = ip
	self.port = port
	self.socket = socket.tcp()
	self.socket:settimeout(0) 					--非阻塞
	self.socket:setoption("tcp-nodelay", true)  --去掉优化
	self.socket:connect(self.ip, self.port);    --链接

	local function checkConnect( dt )
		--停止定时器
		if self:isConnected() then
			self.isConnected_ = true
			scheduler:unscheduleScriptEntry(self.scheduler_id)

			self.precess_id = scheduler:scheduleScriptFunc(function ( ... )
				self:processSocketIO()
			end, 0.05, false)
		end
	end
	self.scheduler_id = scheduler:scheduleScriptFunc(checkConnect, 0.05, false)
end

function NetWork:isConnected()
	local forWrite = {}
	table.insert(forWrite, self.socket)
	local readyForWrite, _;
	_, readyForWrite,_ = socket.select(nil, forWrite, 0)
	if #readyForWrite > 0 then
		return true
	end
	return false
end

function NetWork:processSocketIO()
	if not self.isConnected_ then
		return
	end
	self:processInput()
	self:processOutput()
end

function NetWork:processInput()
	--检测是否有可读的socket
	local recvt, sendt, status = socket.select({self.socket}, nil, 1)
	print("input", #recvt, sendt, status)
	if #recvt <= 0 then
		return
	end

	--先接收两个字节计算包长度
	local buffer, err = self.socket:receive(2)
	if buffer then
		--计算包的长度
		local first, second = string.byte(buffer, 1, 2)
		local len = first * 256 + second --通过位计算长度
		print("收到数据长度=",len)

		--接收整个数据
		local buffer, err = self.socket:receive(len)

		--解析包
		local pbLen, pbHead, pbBody, t = string.unpack(buffer, ">PPb")
		local msgHead = protobuf.decode("PbHead.MsgHead", pbHead)
		local msgBody = protobuf.decode(msgHead.msgname, pbBody)
		print("收到服务器数据", msgHead.msgname)

		print("msgHead.msgtype " .. msgHead.msgtype .. "msgHead.msgname " ..msgHead.msgname .. "msgHead.msgret " ..msgHead.msgret)
		print("msgBody.platform " .. msgBody.platform .. "msgBody.msgname " ..msgBody.user_id )
	end
end

function NetWork:processOutput()
	if self.sendTaskList and #self.sendTaskList > 0 then
		local data = self.sendTaskList[#self.sendTaskList]
		if data then
			local _len, _error = self.socket:send(data)
			print("socket send"..#data, "_len:", _len, "error:", _error)
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
	--拼装头
	local msgHead = {msgtype = 1, msgname = msgName, msgret = 0}
	local pbHead = protobuf.encode("PbHead.MsgHead", msgHead)
	local pbBody = protobuf.encode(msgName, msgBody)
	--计算长度
	local pbHeadLen = #pbHead
	local pbBodyLen = #pbBody
	local pbLen = 2 + pbHeadLen + 2 + pbBodyLen + 1

	local data = string.pack(">HPPb", pbLen, pbHead, pbBody, string.byte("t"))
	print("GameNet send msg:"..msgName..":"..string.char(string.byte('t')))
	table.insert(self.sendTaskList, 1, data)
end

return NetWork
