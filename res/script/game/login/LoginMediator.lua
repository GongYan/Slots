
local LoginMediator = class("LoginMediator", FILE.Mediator)

function LoginMediator:onRegister()

	Event:registerEventListener(EventCfg.ON_LOGIN, self.viewComponent, function(eventType, data )
		self:sendNotification(AppCfg.LOGIN ,data)
	end )

	Event:registerEventListener(EventCfg.ON_SERVER, self.viewComponent, function(eventType, data )
		self:sendNotification(AppCfg.LOGIN ,data)
	end )
end

function LoginMediator:onRemove()
	Event:removeTargetAllEventListener(self.viewComponent)
end

function LoginMediator:handleNotification(note)
	local name = note:getName()
	local body = note:getBody()
	if name == AppCfg.USER_LOGIN_SUCCESS then
		local serverProxy = AppFacade:retrieveProxy("ServerProxy")
		local servers = serverProxy:getServers()
		self.viewComponent:updateServerList(servers)
	elseif name == AppCfg.USER_LOGIN_FAILED then
		self.viewComponent:displayLoginError()
	end
end

function LoginMediator:listNotificationInterests()
	return { AppCfg.USER_LOGIN_SUCCESS,  AppCfg.USER_LOGIN_FAILED}
end

return LoginMediator