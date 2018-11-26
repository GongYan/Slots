local BootstrapModel = class("BootstrapModel", FILE.SimpleCommand)

function BootstrapModel:execute(notification)
	--节点树
	self.facade:registerProxy(FILE.ContextProxy:create({}))
end


return BootstrapModel