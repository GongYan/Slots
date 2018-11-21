local Notifier = require("script.framework.puremvc.patterns.observer.Notifier");

---------------------------
--@module MacroCommand
local MacroCommand = class("MacroCommand", Notifier);


---------------------------
--@function [parent=#MacroCommand] execute
--@param self MacroCommand
--@param #Notification notification
function MacroCommand:execute(notification)
    self.subCommands = {};
    self:initializeMacroCommand();   
end


---------------------------
--@function [parent=#MacroCommand] initializeMacroCommand
--@param self MacroCommand
function MacroCommand:initializeMacroCommand()
	
end



---------------------------
--@function [parent=#MacroCommand] addSubCommand
--@param self MacroCommand
--@param commandClassRef
function MacroCommand:addSubCommand(commandClassRef)
    table.insert(self.subCommands,#self.subCommands + 1, commandClassRef);
end



---------------------------
--@final 
--@function [parent=#MacroCommand] execute
--@param self MacroCommand
--@param #Notification notification
function MacroCommand:execute(notification)
    while(#self.subCommands > 0)
    do
        local commandInstance = self.subCommands[1]:create();
        table.remove(self.subCommands, 1);
        commandInstance:execute(notification);
    end
end


---------------------------
--@function [parent=#MacroCommand] ctor
--@param self MacroCommand
function MacroCommand:ctor()
    MacroCommand.super.ctor(self);
end

return MacroCommand;