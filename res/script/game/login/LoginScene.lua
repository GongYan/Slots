
local LoginScene = class("LoginScene", FILE.BaseScene)

function LoginScene:ctor()
	LoginScene.super.ctor(self)
	Event:dispatchEvent(EventCfg.ON_LOGIN, {username = 'test', password = "test"})
end

function LoginScene:updateServerList(servers)

    -- test on server
    Event:dispatchEvent(EventCfg.ON_SERVER, servers[1])
end

function LoginScene:displayLoginError()
    print("can not login to server")
end

function LoginScene:onExit()
	LoginScene.super.onExit()
end

function LoginScene:onEnter()
	LoginScene.super.onEnter()
	print("okkkk")
end

return LoginScene