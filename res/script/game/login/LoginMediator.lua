
local LoginMediator = class("LoginMediator", FILE.BaseMediator)

function LoginMediator:onRegister()
	self:addBtnPressedListener(self.viewComponent.Btn_vist, handler(self, self.onClickVist))
end

function LoginMediator:onClickVist()
	self:sendNotification(AppCfg.LOGIN ,data)
	Tools.log("onClickVist")
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