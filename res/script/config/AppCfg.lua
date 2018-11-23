--游戏内系统通知
local AppCfg = {
	LOGIN = "LOGIN",
	USER_LOGIN_SUCCESS 	= "USER_LOGIN_SUCCESS",
	USER_LOGIN_FAILED 	= "USER_LOGIN_FAILED",

	-------------场景切换 begin ---------------
	GO_TO_SCENE 	= "GO_TO_SCENE", --换场景
	LOAD_SCENE 		= "LOAD_SCENE", --清空当前场景树，并加载新场景树
	LOAD_LAYERS 	= "LOAD_LAYERS",--（递归）加载除根节点（场景）外的所有子节点（层）
	REMOVE_LAYERS	= "REMOVE_LAYERS", --- （递归）移除根节点（场景）外的所有子节点（层）
	GO_BACK			= "GO_BACK", --返回前一场景
	-------------场景切换 end   ---------------
}
return AppCfg