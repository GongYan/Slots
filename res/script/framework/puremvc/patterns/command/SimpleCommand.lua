local Notifier = FILE.Notifier

---
-- 
--@module SimpleCommand
local SimpleCommand = class("SimpleCommand", Notifier);


---------------------------
--@function [parent=#SimpleCommand] execute
--@param self MacroCommand
--@param #Notification notification
function SimpleCommand:execute(notification)
	
end

---------------------------
--@function [parent=#SimpleCommand] name
--@param self SimpleCommand
function SimpleCommand:ctor()
    SimpleCommand.super.ctor(self);
end


return SimpleCommand;