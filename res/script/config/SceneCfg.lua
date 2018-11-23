--场景配置
local SceneCfg = {}
SceneCfg.NULL = 0   --不允许用
SceneCfg.LOGIN = 1  --登陆场景

SceneCfg[SceneCfg.LOGIN] = {
	Mediator = FILE.LoginMediator,
	Scene = FILE.LoginScene,
}

return SceneCfg