local Utils = cc.exports.Utils
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()


    local spr =  cc.Sprite:create("HelloWorld.png")
    spr:setPosition(display.center)
    self:addChild(spr)

    Utils.customShader(spr, "script/component/shader/Twish")


    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

end

return MainScene
