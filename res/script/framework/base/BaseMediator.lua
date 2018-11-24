
local BaseMediator = class("BaseMediator", FILE.Mediator)

function BaseMediator:setContextData(contextData)
	self.contextData = contextData
end

function BaseMediator:getContextData()
	return self.contextData
end

return BaseMediator