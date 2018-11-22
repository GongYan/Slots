
local GameMediator = class("GameMediator", FILE.Mediator)

function GameMediator:listNotificationInterests()
	return { AppCfg.GO_TO_SCENE };
end

function GameMediator:handleNotification(notification)
    local name = notification:getName()
    local data = notification:getBody()

    local context = FILE.Context:create()
    --load context data
    for k, v in pairs(data) do
    	context.data[k] = v
    end 

    if name == AppCfg.GO_TO_SCENE then
    	local scene_type = notification:getType()
    	if scene_type == SceneCfg.LOGIN then
    		context.mediatorClass = FILE.LoginMediator
    		context.viewComponentClass = FILE.LoginScene
    	end
    end
    self:sendNotification(AppCfg.LOAD_SCENE, context)
end

function GameMediator:onRegister()
	
end

function GameMediator:onRemove()
	
end

return GameMediator