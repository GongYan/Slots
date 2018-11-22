
local SimpleCommand = require("script.framework.puremvc.patterns.command.SimpleCommand");
local DirectorMediator = require("script.game.DirectorMediator")
local ServerProxy = require("script.game.login.ServerProxy")
local StartupCommand = class("StartupCommand", SimpleCommand)

function StartupCommand:execute(notification)
	-- AppFacade:registerCommand(AppCfg.xxx, xxxcomman)

	AppFacade:registerProxy(ServerProxy:create())
	AppFacade:registerMediator( DirectorMediator:create("DirectorMediator") )
end


return StartupCommand