
local StartupCommand = class("StartupCommand", FILE.SimpleCommand)

function StartupCommand:execute(notification)
	--场景控制命令
	self.facade:registerCommand(AppCfg.LOAD_LAYERS, FILE.LoadLayersCommand)
	self.facade:registerCommand(AppCfg.LOAD_SCENE, FILE.LoadSceneCommand)
	self.facade:registerCommand(AppCfg.REMOVE_LAYERS, FILE.RemoveLayersCommand)
	self.facade:registerCommand(AppCfg.GO_BACK, FILE.BackSceneCommand)

	--节点树
	self.facade:registerProxy(FILE.ContextProxy:create({}))

	--场景管理
	self.facade:registerMediator( FILE.GameMediator:create() )
end


return StartupCommand