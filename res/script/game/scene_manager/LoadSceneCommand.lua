local LoadSceneCommand = class('LoadSceneCommand', FILE.SimpleCommand)

function LoadSceneCommand:execute(notification)
    local body = notification:getBody()
    local context = body.context
    if not context.viewClass then
        Utils.log("LoadSceneCommand.execute-> context.viewClass is nil")
        return 
    end
    if not context.mediatorClass then
        Utils.log("LoadSceneCommand.execute-> context.mediatorClass is nil")
        return 
    end

    local contextProxy = self.facade:retrieveProxy("ContextProxy")
    local toScene = context.viewClass:create()
    local function onEnter(eventName, view)
        Event:removeTargetEventListenerByType(toScene, EventCfg.SCENE_ENTER)
        local mediator = context.mediatorClass:create( view)
        self.facade:registerMediator(mediator)
        --去加所有Layer
        self:sendNotification(AppCfg.LOAD_LAYERS, {
            context = context
        })
    end
    Event:registerEventListener(EventCfg.SCENE_ENTER, toScene, onEnter)

    local function nextScene()
        if context.cleanStack then
            contextProxy:cleanContext()
        end
        contextProxy:pushContext(context)
        cc.Director:getInstance():replaceScene(toScene)
    end

    local prevContext = body.prevContext or contextProxy:getCurrentContext()
    local function onRemoved()
        self.facade:removeMediator(prevContext.mediatorClass.__cname)
        nextScene()
    end
    
    if prevContext ~= nil then
        self:sendNotification(AppCfg.REMOVE_LAYERS, {
            context = prevContext,
            onFinish = onRemoved
        })
    else
        nextScene()
    end
end

return LoadSceneCommand