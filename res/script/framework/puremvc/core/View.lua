
local Observer = FILE.Observer
---------------------------
--@module org.puremvc.core.View
local View = class("View");


---------------------------
-- 全局视图单例。
--@field [parent=#src.org.puremvc.core.View] #View instance
View.instance = nil;


View.SINGLETON_MSG = "View Singleton already constructed!";

---------------------------
--@param
--@return
function View:ctor(parameters)
    if View.instance ~= nil then 
        error(View.SINGLETON_MSG)
    end
    View.instance = self;
    self.mediatorMap = {};
    self.observerMap = {};  
    self:initializeView();   
end



---------------------------
--@return #View
function View:getInstance()
    if ( View.instance == nil ) then
        View.instance = View:create( ) 
    end;
    return View.instance;
end

---------------------------
function View:initializeView()
    
end

---------------------------
--@param
--@return
function View:registerObserver(notificationName, observer)
    local observers = self.observerMap[ notificationName ];
    if observers then
        table.insert(observers, #observers+1, observer);
    else 
        self.observerMap[ notificationName ] = {observer}; 
    end
end

---------------------------
--@param
--@return
function View:notifyObservers(notification)
    if self.observerMap[ notification:getName() ] ~= nil then
    
        -- Get a reference to the observers list for this notification name
        local observers_ref = self.observerMap[ notification:getName() ];
        
        
        -- Copy observers from reference array to working array, 
        -- since the reference array may change during the notification loop
        local observers = {}; 
        local observer;
        for key, var in ipairs(observers_ref) do
            observer = var;
            table.insert(observers,#observers + 1, observer);
        end
        
        -- Notify Observers from the working array  
        for key, var in ipairs(observers) do
        	var:notifyObserver( notification );
        end
    end
end

---------------------------
--@function [parent=#View] removeObserver
-- @param self View
--@param notificationName String
--@param notifyContext 
function View:removeObserver( notificationName, notifyContext )
    -- the observer list for the notification under inspection
    local observers = self.observerMap[ notificationName ];

    -- find the observer for the notifyContext
    for key, var in ipairs(observers) do
    	if var:compareNotifyContext( notifyContext ) == true  then 
            -- there can only be one Observer for a given notifyContext 
            -- in any given Observer list, so remove it and break
            table.remove(observers,1);
            break;
        end
    end
    
    -- Also, when a Notification's Observer list length falls to 
    -- zero, delete the notification key from the observer map
    if ( #observers == 0 ) then
        self.observerMap[ notificationName ] = nil;     
    end
end

---------------------------
--@function [parent=#View] registerMediator
--@param self View
--@param mediator
function View:registerMediator(mediator)

    if ( self.mediatorMap[ mediator:getMediatorName() ] ~= nil ) then
        return 
    end;
    
    self.mediatorMap[ mediator:getMediatorName() ] = mediator;
    
    local interests = mediator:listNotificationInterests();
    
    if #interests > 0 then
        
        local observer = Observer:create( mediator.handleNotification, mediator );
        for key, var in ipairs(interests) do
            self:registerObserver(var, observer); 
        end
    end
    
    mediator:onRegister();
end

---------------------------
-- 获得中介器引用。
--@function [parent=#View] retrieveMediator
--@param self View
--@param mediatorName String
--@return #Mediator
function View:retrieveMediator(mediatorName)
    return self.mediatorMap[ mediatorName ];
end



---------------------------
-- 
--@function [parent=#View] removeMediator
--@param self View
--@param mediatorName string 
--@return #Mediator
function View:removeMediator(mediatorName)
    local mediator = self.mediatorMap[ mediatorName ];

    if mediator ~= nil then
        local var = mediator:listNotificationInterests();
        for key, var in ipairs(interests) do
            self:removeObserver( var, mediator );
        end

        self.mediatorMap[ mediatorName ] = nil;
        mediator:onRemove();
    end

    return mediator;
end

---------------------------
--@function [parent=#View] hasMediator
--@param self View
--@param mediatorName String
--@return #boolean
function View:hasMediator(mediatorName)
    return self.mediatorMap[ mediatorName ] ~= nil;
end



return View;