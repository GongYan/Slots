
local BaseScene = class("BaseScene", cc.Scene)

function BaseScene:ctor()
    self:registerScriptHandler(handler(self, self.onNodeEvent))		
end

function BaseScene:onNodeEvent(eventName)
	if "enter" == eventName then
		self:onEnter()
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
	Event:dispatchEvent(EventCfg.SCENE_ENTER, self)
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