
local LoginScene = class("LoginScene", cc.Scene)

function LoginScene:ctor()
	AppFacade:startUp(self)
	Event.dispatchEvent(EventCfg.ON_LOGIN, {username = 'test', password = "test"})
end

function LoginScene:updateServerList(servers)

    -- test on server
    Event.dispatchEvent(EventCfg.ON_SERVER, servers[1])
end

function LoginScene:displayLoginError()
    print("can not login to server")
end

return LoginScene