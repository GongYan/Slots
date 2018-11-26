
local GameClient = class("GameClient")
local M = GameClient

-- --create first scene of your game
-- local function createScene()
-- 	-- local ip = "127.0.0.1"
-- 	-- local port = 3000
-- 	-- local net = NetWork:getInstance()
-- 	-- print("链接")
-- 	-- net:connect(ip, port)
-- 	-- print("发送数据")

-- 	-- local idx = 10
-- 	-- for i = 1, 10 do 
-- 	-- 	net:send("PbLogin.MsgLoginReq", {platform = 1, user_id = "gong " ..i })
-- 	-- 	idx = idx * 10
-- 	-- end
-- end

local setDesignResolution = function ()
	local framesize = cc.Director:getInstance():getOpenGLView():getFrameSize()
    local autoscale = cc.ResolutionPolicy.FIXED_WIDTH
	local ratio = framesize.width / framesize.height
	if ratio <= 1.34 then
		-- iPad 768*1024(1536*2048) is 4:3 screen
		autoscale = cc.ResolutionPolicy.FIXED_WIDTH
	elseif ratio >= 1.78 then
		autoscale = cc.ResolutionPolicy.FIXED_HEIGHT
	end
	
	-- 模块内用模块内的适配策略
	cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(1280, 720, autoscale)
end

--game client start...
function M:start()
	setDesignResolution()
	require("script.init")
	AppFacade:startUp() --统一由mvc框架管理游戏内所有
end

function M:gameEnd()

end

return M