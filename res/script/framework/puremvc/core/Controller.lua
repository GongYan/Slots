local View = require("script.framework.puremvc.core.View");
local Observer = require("script.framework.puremvc.patterns.observer.Observer");
---------------------------
--@module org.puremvc.core.Controller
local Controller = class("Controller");

Controller.instance = nil;

Controller.SINGLETON_MSG = "Controller Singleton already constructed!";



---------------------------
--@function [parent=#Controller] ctor
-- @param self Controller
function Controller:ctor()
	if (Controller.instance ~= nil) then 
	   error(Controller.SINGLETON_MSG);
	end
    Controller.instance = self;
    self.commandMap = {};   
    self:initializeController(); 
end

---------------------------
--@function [parent=#Controller] getInstance
-- @param self Controller
-- @return #Controller 
function Controller:getInstance()
    if ( Controller.instance == nil ) then
        Controller.instance = Controller:create( );
    end
    return Controller.instance;
end


---------------------------
--@function [parent=#Controller] initializeController
-- @param self Controller
function Controller:initializeController()
    self.view = View:getInstance();
end


---------------------------
--@function [parent=#Controller] executeCommand
--@param self Controller
--@param #Notification note
function Controller:executeCommand(note)
    local commandClassRef  = self.commandMap[ note:getName() ];
    if ( commandClassRef == nil ) then 
        do return end
    end;

    local commandInstance = commandClassRef:create();
    commandInstance:execute( note );
end

---------------------------
--@function [parent=#Controller] registerCommand
--@param self Controller
--@param notificationName String
--@param commandClassRef table 
function Controller:registerCommand(notificationName, commandClassRef)
    if ( self.commandMap[ notificationName ] == nil ) then 
        self.view:registerObserver( notificationName, Observer:create( self.executeCommand, self ) );
    end
    self.commandMap[ notificationName ] = commandClassRef;
end


---------------------------
--@function [parent=#Controller] hasCommand
--@param self Controller
--@param #Notification notificationName
--@return #boolean
function Controller:hasCommand(notificationName)
    return self.commandMap[ notificationName ] ~= nil;
end


---------------------------
--@function [parent=#Controller] removeCommand
-- @param self Controller
--@param notificationName String
function Controller:removeCommand(notificationName)
    -- if the Command is registered...
    if ( self:hasCommand( notificationName ) ) then
        -- remove the observer
        self.view:removeObserver( notificationName, self );
                  
        -- remove the command
        self.commandMap[ notificationName ] = nil;
    end
end

return Controller;