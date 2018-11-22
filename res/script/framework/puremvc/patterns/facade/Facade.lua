local Model = FILE.Model
local Controller = FILE.Controller
local View = FILE.View
local Notification = FILE.Notification

---------------------------
--@module script.framework.puremvc.patterns.facade.Facade
local Facade = class("Facade");

Facade.instance = nil;

Facade.SINGLETON_MSG = "Facade Singleton already constructed!";

---------------------------
--@function [parent=#Facade] ctor
-- @param self Facade
function Facade:ctor()
	if (Facade.instance ~= nil) then
	   error(Facade.SINGLETON_MSG) 
    end;
    self.model = nil;
    self.view = nil;
    self.controller = nil;
    self:initializeFacade(); 
    Facade.instance = self;
end

---------------------------
--
--@function [parent=#org.puremvc.patterns.facade.Facade] initializeFacade
--@param self Facade
function Facade:initializeFacade()
	self:initializeModel();
    self:initializeController();
    self:initializeView();
end

---------------------------
--@function [parent=#Facade] getInstance
--@param self Facade
--@return #src.org.puremvc.patterns.facade.Facade
function Facade:getInstance()
    if (Facade.instance == nil) then
        Facade.instance = Facade:create( ) 
    end
    return Facade.instance;
end

---------------------------
--@function [parent=#Facade] initializeController
-- @param self Facade
function Facade:initializeController()
    print("Facade:initializeController()");
    if ( self.controller ~= nil ) then
        do return end;
    end
    self.controller = Controller:getInstance();
    print(self.controller);
end

---------------------------
--@function [parent=#Facade] initializeModel
-- @param self Facade
function Facade:initializeModel()
    print("Facade:initializeModel()");
    if ( self.model ~= nil ) then 
        do return end;
    end
    self.model = Model:getInstance();
    print(self.model);
end

---------------------------
--@function [parent=#Facade] initializeView
-- @param self Facade
function Facade:initializeView()
    print("Facade:initializeView()");
    if ( self.view ~= nil ) then 
        do return end;
    end
    self.view = View:getInstance();
    print(self.view);
end

---------------------------
--@function [parent=#Facade] registerCommand
--@param self Facade
--@param notificationName String description
--@param commandClassRef 
function Facade:registerCommand(notificationName, commandClassRef)
    self.controller:registerCommand( notificationName, commandClassRef );
end

---------------------------
--@function [parent=#Facade] removeCommand
--@param self Facade
--@param #String notificationName
function Facade:removeCommand(notificationName)
    self.controller:removeCommand( notificationName );
end

---------------------------
--@function [parent=#Facade] hasCommand
-- @param self Facade
--@param #String notificationName
--@return #Boolean
function Facade:hasCommand(notificationName)
    return self.controller:hasCommand( notificationName );
end

---------------------------
--@function [parent=#Facade] registerProxy
--@param self Facade
--@param #Proxy proxy
function Facade:registerProxy(proxy)
	self.model:registerProxy( proxy ); 
end

---------------------------
--@function [parent=#Facade] retrieveProxy
--@param self Facade
--@param #String proxyName
--@return #Proxy
function Facade:retrieveProxy(proxyName)
    print("Facade:retrieveProxy(proxyName) self " .. type(self));
    for key, var in pairs(self) do
    	print(key);
    end
    return self.model:retrieveProxy( proxyName );   
end

---------------------------
--@function [parent=#Facade] removeProxy
--@param self Facade
--@param #String proxyName
--@return #Proxy
function Facade:removeProxy(proxyName)
    local proxy;
    if ( self.model ~= nil ) then 
        proxy = self.model:removeProxy ( proxyName );
    end   
    return proxy
end

---------------------------
--@function [parent=#Facade] hasProxy
--@param self Facade
--@param #String proxyName
--@return #Boolean
function Facade:hasProxy(proxyName)
    return self.model:hasProxy( proxyName );
end

---------------------------
--@param #Mediator mediator
function Facade:registerMediator(mediator)
    if ( self.view ~= nil )then 
        self.view:registerMediator( mediator )
    end;
end

---------------------------
--@param #String mediatorName
--@return  #Mediator
function Facade:retrieveMediator(mediatorName)
    return self.view:retrieveMediator( mediatorName );
end

---------------------------
--@param #String mediatorName
--@return #Mediator     
function Facade:removeMediator(mediatorName)
    local mediator;
    if ( self.view ~= nil ) then
        mediator = self.view:removeMediator( mediatorName );  
    end       
    return mediator;
end

---------------------------
--@param #String mediatorName
--@return #Boolean
function Facade:hasMediator(mediatorName)
    return self.view:hasMediator( mediatorName );
end

---------------------------
--@param notificationName String 
--@param body 
--@param type String
function Facade:sendNotification(notificationName, body, type)
	self:notifyObservers( Notification:create( notificationName, body, type ) );
end

---------------------------
--@param #Notification notification
function Facade:notifyObservers(notification)
    if ( self.view ~= nil ) then
        self.view:notifyObservers( notification )
    end
end


return Facade;