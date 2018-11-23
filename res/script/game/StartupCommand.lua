
local StartupCommand = class("StartupCommand", FILE.SimpleCommand)

function StartupCommand:execute(notification)
	--命令
	self.facade:registerCommand(AppCfg.LOAD_LAYERS, FILE.LoadLayersCommand)
	self.facade:registerCommand(AppCfg.LOAD_SCENE, FILE.LoadSceneCommand)
	self.facade:registerCommand(AppCfg.REMOVE_LAYERS, FILE.RemoveLayersCommand)
	self.facade:registerCommand(AppCfg.GO_BACK, FILE.BackSceneCommand)

	--代理
	self.facade:registerProxy(FILE.ContextProxy:create({}))

	--中介者
	self.facade:registerMediator( FILE.GameMediator:create() )
end


return StartupCommand