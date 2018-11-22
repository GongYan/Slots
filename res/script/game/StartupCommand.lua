
local SimpleCommand = require("script.framework.puremvc.patterns.command.SimpleCommand");
local LoginMediator = require("script.game.login.LoginMediator")
local ServerProxy = require("script.game.login.ServerProxy")
local StartupCommand = class("StartupCommand", SimpleCommand)

function StartupCommand:execute(notification)
	-- AppFacade:registerCommand(AppCfg.xxx, xxxcomman)

	AppFacade:registerProxy(ServerProxy:create())
	local rootView = notification:getBody()
	AppFacade:registerMediator( LoginMediator:create("LoginMediator", rootView) )
end


return StartupCommand