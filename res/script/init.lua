
--config 
cc.exports.EventCfg = require("script.config.EventCfg")
cc.exports.MsgCfg = require("script.config.MsgCfg")
cc.exports.AppCfg = require("script.config.AppCfg")

--framework
cc.exports.Event = require("script.framework.event.Event")
cc.exports.Utils = require("script.util.Utils")
cc.exports.AppFacade = require("script.AppFacade"):getInstance()

--net pbc    
require("script.component.pbc.pbc")
require("script.component.net.NetWork")