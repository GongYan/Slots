local BackSceneCommand = class('BackSceneCommand', FILE.SimpleCommand)

function BackSceneCommand:execute(notification)
    local body = notification:getBody()
    local contextProxy = self.facade:retrieveProxy("ContextProxy")
    if contextProxy:getContextCount() > 1 then
        local currentContext = contextProxy:popContext()
        local prevContext = contextProxy:popContext()
        prevContext:extendData(body)

        self:sendNotification(AppCfg.LOAD_SCENE, {
            prevContext = currentContext,
            context = prevContext,
        })
    end
end

return BackSceneCommand