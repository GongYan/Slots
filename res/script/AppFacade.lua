
local Facade = require("script.framework.puremvc.patterns.facade.Facade")
local StartupCommand = require("script.game.StartupCommand")

local AppFacade = class("AppFacade", Facade)
AppFacade.STARTUP = "startup"

function AppFacade:getInstance()
    if (AppFacade.instance == nil) then
        AppFacade.instance = AppFacade:create( ) 
    end
    return AppFacade.instance;
end

function AppFacade:initializeController()
	AppFacade.super.initializeController(self)
	self:registerCommand(AppFacade.STARTUP, StartupCommand)
end

function AppFacade:startUp(rootView)
	self:sendNotification(AppFacade.STARTUP,  rootView )
	self:removeCommand(AppFacade.STARTUP)
end


return AppFacade