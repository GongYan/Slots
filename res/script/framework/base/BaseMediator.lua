
local BaseMediator = class("BaseMediator", FILE.Mediator)

function BaseMediator:setContextData(contextData)
	self.contextData = contextData
end

function BaseMediator:getContextData()
	return self.contextData
end

function BaseMediator:addSubLayers( context )
	local contextProxy = self.facade:retrieveProxy("ContextProxy")
	local currentContext = contextProxy:getCurrentContext()
	local parentContext = currentContext:getContextByMediatorName(self.__name)

    self:sendNotification(AppCfg.LOAD_LAYERS, {
    	parentContext = parentContext,
        context = context
    })
end


-- start --
--------------------------------
-- @class function
-- @description 给BUTTON注册触屏事件
-- @param btn 注册按钮
-- @param listener 注册事件回调
-- end --
function BaseMediator:addBtnPressedListener(btn, listener)
	if not btn or not listener then
		return
	end

	btn:addClickEventListener(function(sender)
		listener(sender)
	end)
end

return BaseMediator