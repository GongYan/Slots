--[[
 @Create By CQF

--]]

--local Facade = import("org.puremvc.patterns.facade.Facade"); -- 这个是全局的。

---------------------------
-- 通知者，用于发送通知。
--
--@module org.puremvc.patterns.observer.Notifier
local Notifier = class("Notifier");




---------------------------
--发送通知。
--@function [parent=#src.org.puremvc.patterns.observer.Notifier] sendNotification
--@param self 
--@param #String notificationName
--@param #Ref body 
--@param #String type 
--@return 
--
function Notifier:sendNotification( notificationName, body , type)
    self.facade:sendNotification(notificationName, body, type);
end

---------------------------
--@function [parent=#src.org.puremvc.patterns.observer.Notifier] ctor
--@param self Notifier 
function Notifier:ctor()
	self.facade = Facade:getInstance();
end

return Notifier;