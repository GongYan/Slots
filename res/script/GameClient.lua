local GameClient = class("GameClient")
local M = GameClient

--do some initial for your game
local function init()
	require("script.util.Utils")
    --初始化pbc    
    require("script.component.pbc.pbc")
    require("script.component.net.NetWork")
end

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
	
    require("app.MyApp"):create():run()
end

--game client start...
function M:start()
	init()
	createScene()
end

function M:gameEnd()

end

return M