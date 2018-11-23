local Notifier = FILE.Notifier

---------------------
-- 视图中介器。
--@module org.puremvc.patterns.mediator.Mediator
local Mediator = class("Mediator", Notifier);

---------------------------
--@function [parent=#Mediator] ctor
--@param self Facade
--@param viewComponent Ref
function Mediator:ctor(viewComponent)
    Mediator.super.ctor(self);
    self.viewComponent = viewComponent; 
end


---------------------------
--@function [parent=#Mediator] getMediatorName
--@param self Facade
--@return #String
function Mediator:getMediatorName()   
    return self.__cname;
end

---------------------------
--@function [parent=#Mediator] setViewComponent
--@param self Facade
--@param #Ref viewComponent
function Mediator:setViewComponent( viewComponent )
    self.viewComponent = viewComponent;
end

---------------------------
--@function [parent=#Mediator] getViewComponent
--@param self Facade
--@return #Ref
function Mediator:getViewComponent()
    return self.viewComponent;
end



---------------------------
--@function [parent=#Mediator] listNotificationInterests
--@param self Facade
--@return #Array
function Mediator:listNotificationInterests()
	return {};
end


---------------------------
--@function [parent=#Mediator] handleNotification
--@param self Facade
--@param #Notification notification
function Mediator:handleNotification(notification)
	
end



---------------------------
--@function [parent=#Mediator] onRegister
--@param self Facade
function Mediator:onRegister()
	
end


---------------------------
--@function [parent=#Mediator] onRemove
--@param self Facade
function Mediator:onRemove()
	
end

return Mediator;