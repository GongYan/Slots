
local Mediator = require("script.framework.puremvc.patterns.proxy.Proxy");
local ServerProxy = class("ServerProxy", Mediator)

function ServerProxy:getServers()
	return {1,2,3,4}
end

function ServerProxy:onRegister( ) 
    
end


function ServerProxy:onRemove( )

end

return ServerProxy