
local AppFacade = class("AppFacade", FILE.Facade)
AppFacade.STARTUP = "startup"

function AppFacade:getInstance()
    if (AppFacade.instance == nil) then
        AppFacade.instance = AppFacade:create( ) 
    end
    return AppFacade.instance;
end

function AppFacade:initializeController()
	AppFacade.super.initializeController(self)
	self:registerCommand(AppFacade.STARTUP, FILE.StartupCommand)
end

function AppFacade:startUp()
	self:sendNotification(AppFacade.STARTUP)
	self:removeCommand(AppFacade.STARTUP)
	self:sendNotification(AppCfg.GO_TO_SCENE, {}, SceneCfg.LOGIN ) --去登陆场景
end


return AppFacade