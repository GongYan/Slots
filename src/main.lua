
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
cc.FileUtils:getInstance():addSearchPath("res/resource")

require('socket')
require "config"
require "cocos.init"


local function main()
    local gameClient = require("script.GameClient")
    gameClient.start()    
end

-- cclog
local function cclog(...)
    print(string.format(...))
end

local function __G__TRACKBACK__M(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    ---[[
    local log = ""
    log = log.."----------------------------------------\n"
    log = log.."LUA ERROR: " .. tostring(msg) .. "\n"
    log = log..debug.traceback() .. "\n"
    log = log.."----------------------------------------\n"
    --ErrorFile:close()
    local path = cc.FileUtils:getInstance():getWritablePath().."error.log"
    if nil == errorFilePath then errorFilePath = io.open(path,"w") end
    errorFilePath:write(log)
    errorFilePath:flush()
    --]]
    return msg
end

local status, msg = xpcall(main, __G__TRACKBACK__M)
if not status then
    print(msg)
end
