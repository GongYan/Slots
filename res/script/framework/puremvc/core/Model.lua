---------------------------
--@module org.puremvc.core.Model
local Model = class("Model");

---------------------------
--@field [parent=#src.org.puremvc.core.Model] #Model instance description
Model.instance = nil;


Model.SINGLETON_MSG = "Model Singleton already constructed!";

---------------------------
--@function [parent=#Model] ctor
--@param self Model
function Model:ctor()
	if (Model.instance ~= null) then 
	   error(Model.SINGLETON_MSG)
	end;
    Model.instance = self;
    self.proxyMap = {}; 
    print(self);
    self:initializeModel();    
end


---------------------------
--@function [parent=#Model] initializeModel
--@param self Model
function Model:initializeModel()
	
end

---------------------------
--@function [parent=#Model] getInstance
--@param self Model
--@return #Model
function Model:getInstance()
    if ( Model.instance == nil ) then
        Model.instance = Model:create(); 
    end;
    return Model.instance;
end

---------------------------
--@function [parent=#Model] registerProxy
--@param self Model
--@param #Proxy proxy 
function Model:registerProxy(proxy)
    self.proxyMap[ proxy:getProxyName() ] = proxy;
    proxy:onRegister();
end



---------------------------
-- 获得代理引用。
-- @function [parent=#Model] retrieveProxy
-- @param self Model
-- @param #String proxyName
-- @return #Proxy 
function Model:retrieveProxy(proxyName)
    return self.proxyMap[ proxyName ];
end


---------------------------
--@function [parent=#Model] hasProxy
--@param self Model
--@param #String proxyName
--@return #Proxy 数据代理.
function Model:hasProxy(proxyName)
    return self.proxyMap["proxyName"] ~= nil;
end
---------------------------
--@function [parent=#Model] removeProxy
--@param self Model
--@param #String proxyName
--@return #Proxy
function Model:removeProxy(proxyName)
    local proxy = self.proxyMap [ proxyName ];
    if ( proxy ~= nil) then
        self.proxyMap[ proxyName ] = nil;
        proxy:onRemove();
    end
    return proxy;
end

return Model;