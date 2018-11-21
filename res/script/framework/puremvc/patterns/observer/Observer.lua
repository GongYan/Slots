
---------------------------
-- 观察者。
--@module Observer
local Observer = class("Observer");


---------------------------
--@function [parent=#Observer] ctor
-- @param self Observer
--@param notifyMethod 
--@param notifyContext
function Observer:ctor(notifyMethod, notifyContext)
    self:setNotifyMethod( notifyMethod );
    self:setNotifyContext( notifyContext );
end



---------------------------
--@function [parent=#Observer] setNotifyMethod
-- @param self Observer
--@param #Function notifyMethod
function Observer:setNotifyMethod(notifyMethod)
    self.notify = notifyMethod;
end

---------------------------
--@function [parent=#Observer] setNotifyContext
-- @param self Observer
--@param #Ref notifyContext
function Observer:setNotifyContext(notifyContext)
    self.context = notifyContext;
end

---------------------------
--@function [parent=#Observer] getNotifyMethod
-- @param self Observer
--@return #table
function Observer:getNotifyMethod()
    return self.notify;
end

---------------------------
--@function [parent=#Observer] getNotifyContext
-- @param self Observer
--@return #table
function Observer:getNotifyContext()
    return self.context;
end

---------------------------
--@function [parent=#Observer] notifyObserver
-- @param self Observer
--@param
--@return
function Observer:notifyObserver(notification)
    self.notify(self:getNotifyContext(), notification);
end

---------------------------
--@function [parent=#Observer] compareNotifyContext
-- @param self Observer
--@param #table object
--@return #Boolean
function Observer:compareNotifyContext(object)
    return object == self.context;
end


return Observer;