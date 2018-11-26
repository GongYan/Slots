local BootstrapController = class("BootstrapController", FILE.SimpleCommand)

function BootstrapController:execute(notification)
	--场景控制命令
	self.facade:registerCommand(AppCfg.LOAD_LAYERS, FILE.LoadLayersCommand)
	self.facade:registerCommand(AppCfg.LOAD_SCENE, FILE.LoadSceneCommand)
	self.facade:registerCommand(AppCfg.REMOVE_LAYERS, FILE.RemoveLayersCommand)
	self.facade:registerCommand(AppCfg.GO_BACK, FILE.BackSceneCommand)
	
end

return BootstrapController