local FileCfg = {
	--framework
	Observer = require("script.framework.puremvc.patterns.observer.Observer"),
	Notifier = require("script.framework.puremvc.patterns.observer.Notifier"),
	Notification = require("script.framework.puremvc.patterns.observer.Notification"),
	Model = require("script.framework.puremvc.core.Model"),
	View = require("script.framework.puremvc.core.View"),
	Controller = require("script.framework.puremvc.core.Controller"),
	Proxy = require("script.framework.puremvc.patterns.proxy.Proxy")
	Mediator = require("script.framework.puremvc.patterns.mediator.Mediator"),
	MacroCommand = require("script.framework.puremvc.patterns.command.MacroCommand"),
	SimpleCommand = require("script.framework.puremvc.patterns.command.SimpleCommand"),
	Facade = require("script.framework.puremvc.patterns.facade.Facade"),
	--base
	BaseScene = require("script.framework.base.BaseScene"),
	BaseLayer = require("script.framework.base.BaseLayer"),

	Event = require("script.framework.event.Event"),
	--game
	StartupCommand = require("script.game.StartupCommand"),
	AppFacade = require("script.AppFacade"),
	LoginMediator = require("script.game.login.LoginMediator"),
	LoginScene = require("script.game.login.LoginScene"),
	Context = require("script.game.scene_manager.Context"),
}
return FileCfg