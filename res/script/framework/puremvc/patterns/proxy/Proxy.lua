local Notifier = FILE.Notifier


---------------------------
--数据代理。
--@module Proxy
local Proxy = class("Proxy", Notifier);

---------------------------
--@function [parent=#Proxy] ctor
-- @param self Proxy
--@param #string proxyName
--@param #Ref data 
function Proxy:ctor(data)
    Proxy.super.ctor(self);
	self.data = nil;
    if (data ~= nil) then 
        self:setData(data); 
    end
end


---------------------------
--@function [parent=#Proxy] getProxyName
--@param self Proxy
--@return #string
function Proxy:getProxyName()
	return self.__cname;
end

---------------------------
-- @function [parent=#Proxy] getData
-- @param self Proxy
-- @return #Ref 
function Proxy:getData()
    return self.data;
end

---------------------------
--@function [parent=#Proxy] setData
--@param data
--@return
function Proxy:setData(data)
	self.data = data;
end

---------------------------
--注册时调用函数。
--@function [parent=#Proxy] onRegister
-- @param self Proxy
function Proxy:onRegister( ) 
    
end

---------------------------
-- 删除时调用函数。   
-- @function [parent=#Proxy] onRemove
-- @param self Proxy
function Proxy:onRemove( )

end


return Proxy; 