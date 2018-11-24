
local GameMediator = class("GameMediator", FILE.BaseMediator)

function GameMediator:listNotificationInterests()
	return { AppCfg.GO_TO_SCENE };
end

function GameMediator:handleNotification(notification)
    local name = notification:getName()
    local body = notification:getBody()
    local context = FILE.Context:create()
    context:extendData(body)
    if name == AppCfg.GO_TO_SCENE then
    	local scene_type = notification:getType()
        for index, value in ipairs(SceneCfg) do
            if scene_type and index and value and index == scene_type then
                context.mediatorClass = value.Mediator
                context.viewClass = value.Scene
            end
        end
    end
    self:sendNotification(AppCfg.LOAD_SCENE, {context = context})
end

return GameMediator