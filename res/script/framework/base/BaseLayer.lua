
local BaseLayer = class("BaseLayer", cc.Layer)

function BaseLayer:ctor()
    self:registerScriptHandler(handler(self, self.onNodeEvent))		
end

function BaseLayer:onNodeEvent(eventName)
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

function BaseLayer:onEnter()
end

function BaseLayer:onEnterTransitionFinish()
end

function BaseLayer:onExitTransitionStart()
end

function BaseLayer:onExit()
end

function BaseLayer:cleanUp()
end

return BaseLayer