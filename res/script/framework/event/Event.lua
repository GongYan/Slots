local Event = class("Event")
Event.eventsListener = {}

function Event:getInstance()
    if (Event.instance == nil) then
        Event.instance = Event:create( ) 
    end
    return Event.instance;
end

-- start --
--------------------------------
-- @class function registerEventListener
-- @description 注册事件回调
-- @param eventType 事件类型
-- @param target 实例
-- @param method 方法
-- @return
-- registerEventListener(2, self, self.eventLis)
-- end --
function Event:registerEventListener(eventType, target, method)
	if not eventType or not target or not method then
		return
	end
	print("registerMsgListener  ID: ",eventType)
	local eventsListener = Event.eventsListener
	local listeners = eventsListener[eventType]
	if not listeners then
		-- 首次添加eventType类型事件，新建消息存储列表
		listeners = {}
		eventsListener[eventType] = listeners
	else
		-- 检查重复添加
		for _, listener in ipairs(listeners) do
			if listener[1] == target and listener[2] == method then
				print("重复注册：ID:",eventType)
				return
			end
		end
	end

	-- 加入到事件列表中
	local listener = {target, method}
	table.insert(listeners, listener)
end

-- start --
--------------------------------
-- @class function dispatchEvent
-- @description 分发eventType事件
-- @param eventType 事件类型
-- @param ... 调用者传递的参数
-- @return
-- end --
function Event:dispatchEvent(eventType, ...)
	if not eventType then
		return 
	end
	local listeners = Event.eventsListener[eventType] or {}
	if next(listeners) then
		for _, listener in ipairs(listeners) do
			-- 调用注册函数
			if listener[1] and ((type(listener[1]) == "table" and next(listener[1])) or not tolua.isnull(listener[1])) then
				if type(eventType) == "string" and string.sub(eventType,1,7) == "Socket_" then
					listener[2](listener[1], ...) 
				else
					listener[2](listener[1], eventType, ...)
				end	
			end
		end
	else
		-- 没有注册的消息也打印 方便调试
		print("ispatchEvent---->>>Could not handle Message " .. tostring(eventType))
		return "ERROR_NO_HANDLE"
	end
	
end

-- start --
--------------------------------
-- @class function removeTargetEventListenerByType
-- @description 移除target注册的事件
-- @param target self
-- @param eventType 消息类型
-- @return
-- end --
function Event:removeTargetEventListenerByType(target, eventType,isSocketMsg)
	if not target or not eventType then
		return
	end

	if isSocketMsg then
		eventType = "Socket_"..eventType
	end

	-- 移除target的注册的eventType类型事件
	local listeners = Event.eventsListener[eventType] or {}
	for i, listener in ipairs(listeners) do
		if listener[1] == target then
			print("removeMsgListener  ID：",eventType)
			table.remove(listeners, i)
		end
	end
end

-- start --
--------------------------------
-- @class function removeTargetAllEventListener
-- @description 移除target的注册的全部事件
-- @param target self
-- @return
-- end --
function Event:removeTargetAllEventListener(target)
	if not target then
		return
	end

	-- 移除target注册的全部事件
	for _, listeners in pairs(Event.eventsListener) do
		for i, listener in ipairs(listeners) do
			if listener[1] == target then
				print("removeMsgListener  ID：",_)
				table.remove(listeners, i)
			end
		end
	end
end

-- start --
--------------------------------
-- @class function removeAllEventListener
-- @description 移除全部消息注册回调
-- @return
-- end --
function Event:removeAllEventListener()
	Event.eventsListener = {}
end

return Event