local LoadLayersCommand = class('LoadLayersCommand', FILE.SimpleCommand)

function LoadLayersCommand:execute(notification)
    local data = notification:getBody()
    local context = data.context

    local open = {}

    local restoreLayers
    restoreLayers = coroutine.create(function()
        -- restore context tree
        while #open > 0 do
            local context = table.remove(open, 1)
            for _, v in ipairs(context.children) do
                table.insert(open, v)
            end

            local parentContext = context.parent
            local parentMediator = self.facade:retrieveMediator(parentContext.mediatorClass.__cname)
            local parentViewComponent = parentMediator:getViewComponent()

            local viewComponent = context.viewClass:create()
            local finish = false
            local function onFinish()
                Event:removeTargetEventListenerByType(viewComponent, EventCfg.LAYER_ENTER)
                local mediator = context.mediatorClass:create(viewComponent)
                mediator:setContextData(context.data)
                self.facade:registerMediator(mediator)
                coroutine.resume(restoreLayers)
                finish = true
            end
            Event:registerEventListener(EventCfg.LAYER_ENTER, viewComponent, onFinish)
            parentViewComponent:addChild(viewComponent)
            if not finish then coroutine.yield() end
        end

        if data.callback then data.callback() end
    end)

    local parentContext = data.parentContext
    if parentContext ~= nil then
        -- if parentContext:getContextByMediator(context.mediator) then
        --     Utils.log("Mediator already exist: " .. context.mediator.__cname)
        --     return
        -- end

        table.insert(open, context)
        parentContext:addChild(context)
    else
        for _, v in ipairs(context.children) do
            table.insert(open, v)
        end
    end

    -- start restore
    coroutine.resume(restoreLayers)    
end

return LoadLayersCommand