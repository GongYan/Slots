
local LoginScene = class("LoginScene", FILE.BaseScene)

local csb_path = "resource/login/LoginLayer.csb"

function LoginScene:ctor()
	LoginScene.super.ctor(self)
	-- Event:dispatchEvent(EventCfg.ON_LOGIN, {username = 'test', password = "test"})
end

function LoginScene:updateServerList(servers)

    -- test on server
    Event:dispatchEvent(EventCfg.ON_SERVER, servers[1])
end

function LoginScene:displayLoginError()
    print("can not login to server")
end

function LoginScene:onExit()
	LoginScene.super.onExit(self)
end

function LoginScene:onEnter()
	LoginScene.super.onEnter(self)
	self.rootNode = self:loadCSB(csb_path,"LoginLayer")
	self:addChild(self.rootNode)
	self:initWidget()
end

function LoginScene:initWidget()
	self.Btn_vist = self:seekNodeByName(self.rootNode, "Btn_vist")
end

return LoginScene