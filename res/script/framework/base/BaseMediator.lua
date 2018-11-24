
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

return BaseMediator