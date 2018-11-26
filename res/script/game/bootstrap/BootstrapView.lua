local BootstrapView = class("BootstrapView", FILE.SimpleCommand)

function BootstrapView:execute(notification)
	--场景管理
	self.facade:registerMediator( FILE.GameMediator:create() )
end


return BootstrapView