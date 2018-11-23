
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
        for index, value in ipairs(SceneCfg) do
            if scene_type and index and value and index == scene_type then
                context.mediatorClass = value.Mediator
                context.viewComponentClass = value.Scene
            end
        end
    end
    self:sendNotification(AppCfg.LOAD_SCENE, context)
end

return GameMediator