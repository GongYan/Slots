
local GameClient = class("GameClient")
local M = GameClient

--create first scene of your game
local function createScene()
	-- local ip = "127.0.0.1"
	-- local port = 3000
	-- local net = NetWork:getInstance()
	-- print("链接")
	-- net:connect(ip, port)
	-- print("发送数据")

	-- local idx = 10
	-- for i = 1, 10 do 
	-- 	net:send("PbLogin.MsgLoginReq", {platform = 1, user_id = "gong " ..i })
	-- 	idx = idx * 10
	-- end
	
	-- local loginScene = require("script.game.login.LoginScene"):create()
	-- cc.Director:getInstance():replaceScene(loginScene)
end

--game client start...
function M:start()
	require("script.init")
	AppFacade:startUp()
end

function M:gameEnd()

end

return M