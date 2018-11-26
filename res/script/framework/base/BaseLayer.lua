
local BaseLayer = class("BaseLayer", cc.Layer, FILE.BaseView)
BaseLayer.DID_ENTER = "DID_ENTER"
BaseLayer.DID_EXIT = "DID_EXIT"

function BaseLayer:ctor()
    self:registerScriptHandler(handler(self, self.onNodeEvent))		
end

function BaseLayer:onNodeEvent(eventName)
	if "enter" == eventName then
		self:onEnter()
		Event:dispatchEvent((string.format("%s_%s",BaseLayer.DID_ENTER, self.__cname)))
	elseif "enterTransitionFinish" == eventName then
		self:onEnterTransitionFinish()
	elseif "exitTransitionStart" == eventName then
		self:onExitTransitionStart()
	elseif "exit" == eventName then
		self:onExit()
		Event:dispatchEvent((string.format("%s_%s",BaseLayer.DID_EXIT, self.__cname)))
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