local FILE = FILE
--framework
FILE.Observer = require("script.framework.puremvc.patterns.observer.Observer")
FILE.Notifier = require("script.framework.puremvc.patterns.observer.Notifier")
FILE.Notification = require("script.framework.puremvc.patterns.observer.Notification")
FILE.Model = require("script.framework.puremvc.core.Model")
FILE.View = require("script.framework.puremvc.core.View")
FILE.Controller = require("script.framework.puremvc.core.Controller")
FILE.Proxy = require("script.framework.puremvc.patterns.proxy.Proxy")
FILE.Mediator = require("script.framework.puremvc.patterns.mediator.Mediator")
FILE.MacroCommand = require("script.framework.puremvc.patterns.command.MacroCommand")
FILE.SimpleCommand = require("script.framework.puremvc.patterns.command.SimpleCommand")
FILE.Facade = require("script.framework.puremvc.patterns.facade.Facade")
--base
FILE.BaseScene = require("script.framework.base.BaseScene")
FILE.BaseLayer = require("script.framework.base.BaseLayer")
FILE.BaseMediator = require("script.framework.base.BaseMediator")

FILE.Event = require("script.framework.event.Event")

--scene manager 
FILE.Context = require("script.game.scene_manager.Context")
FILE.ContextProxy = require("script.game.scene_manager.ContextProxy")
FILE.LoadLayersCommand = require("script.game.scene_manager.LoadLayersCommand")
FILE.LoadSceneCommand = require("script.game.scene_manager.LoadSceneCommand")
FILE.RemoveLayersCommand = require("script.game.scene_manager.RemoveLayersCommand")
FILE.BackSceneCommand = require("script.game.scene_manager.BackSceneCommand")
FILE.GameMediator = require("script.game.scene_manager.GameMediator")

--bootstrap
FILE.BootstrapController = require("script.game.bootstrap.BootstrapController")
FILE.BootstrapModel = require("script.game.bootstrap.BootstrapModel")
FILE.BootstrapView = require("script.game.bootstrap.BootstrapView")
FILE.StartupCommand = require("script.game.StartupCommand")

--center manager
FILE.AppFacade = require("script.AppFacade")


--game
FILE.LoginMediator = require("script.game.login.LoginMediator")
FILE.LoginScene = require("script.game.login.LoginScene")
