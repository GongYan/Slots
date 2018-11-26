
local BaseScene = class("BaseScene", cc.Scene, FILE.BaseView)
BaseScene.DID_ENTER = "DID_ENTER"

function BaseScene:ctor()
    self:registerScriptHandler(handler(self, self.onNodeEvent))		
end

function BaseScene:onNodeEvent(eventName)
	if "enter" == eventName then
		self:onEnter()
		Event:dispatchEvent((string.format("%s_%s",BaseScene.DID_ENTER, self.__cname)))
	elseif "enterTransitionFinish" == eventName then
		self:onEnterTransitionFinish()
	elseif "exitTransitionStart" == eventName then
		self:onExitTransitionStart()
	elseif "exit" == eventName then
		self:onExit()
	elseif "cleanup" == eventName then
		self:cleanUp()
	end
end

function BaseScene:onEnter()
end

function BaseScene:onEnterTransitionFinish()
end

function BaseScene:onExitTransitionStart()
end

function BaseScene:onExit()
end

function BaseScene:cleanUp()
end

return BaseScene