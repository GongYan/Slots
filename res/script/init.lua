cc.exports.Tools = require("script.framework.tools.Tools")
--config 
cc.exports.SysCfg = require("script.config.SysCfg")
cc.exports.EventCfg = require("script.config.EventCfg")
cc.exports.MsgCfg = require("script.config.MsgCfg")
cc.exports.AppCfg = require("script.config.AppCfg")

cc.exports.FILE = {}
require("script.config.FileCfg")

--framework
cc.exports.Event = FILE.Event:getInstance()
cc.exports.AppFacade = FILE.AppFacade:getInstance()


-- --net pbc    
-- require("script.component.pbc.pbc")
-- require("script.component.net.NetWork")