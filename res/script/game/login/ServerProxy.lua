
local ServerProxy = class("ServerProxy", FILE.Proxy)

function ServerProxy:getServers()
	return {1,2,3,4}
end

function ServerProxy:onRegister( ) 
    
end


function ServerProxy:onRemove( )

end

return ServerProxy