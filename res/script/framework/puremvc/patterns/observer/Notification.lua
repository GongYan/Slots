
---------------------------
-- 通知类.
--
--@module Notification
local Notification = class("Notification");


---------------------------
--
--@function [parent=#Notification] ctor
--@param self Notification 
--@param name string 
--@param body Ref 
--@param type string
function Notification:ctor(name, body, type)
    self.name = name;
    self.body = body;
    self.type = type;
end


---------------------------
--
--@function [parent=#Notification] getName
--@param self Notification 
--@return #string
function Notification:getName()
	return self.name;    
end


---------------------------
--
--@function [parent=#Notification] setBody
--@param self Notification 
--@param body
function Notification:setBody(body)
    self.body = body;
end


---------------------------
--
--@function [parent=#Notification] getBody
--@param self Notification 
--@return #Ref
function Notification:getBody()
    return self.body;
end


---------------------------
--
--@function [parent=#Notification] setType
--@param self Notification 
--@param type string    
function Notification:setType(type)
    self.type = type;
end


---------------------------
--
--@function [parent=#Notification] getType
--@param self Notification 
--@return #string
function Notification:getType()
    return self.type;
end

return Notification;