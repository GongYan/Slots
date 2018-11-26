local RemoveLayersCommand = class('RemoveLayersCommand', FILE.SimpleCommand)

function RemoveLayersCommand:execute(note)
    local data = note:getBody()
    local context = data.context
    local callback = data.onFinish
    -- Breadth-First-Search
    local close = {}
    table.insert(close, context)

    for _, v in ipairs(context.children) do
        table.insert(close, v)
    end

    if context.parent == nil then
        -- do not remove root context
        table.remove(close, 1)
    else
        context.parent:removeChild(context)
    end

    -- remove context tree
    local removeState
    removeState = coroutine.create(function()
        while #close > 1 do
            local context = table.remove(close) -- LIFO
            local subMediator = self.facade:removeMediator(context.mediatorClass.__cname)
            local viewComponent = subMediator:getViewComponent()
            local removed = false
            local exitEventName = (string.format("%s_%s",context.viewClass.DID_EXIT, context.viewClass.__cname)
            local function onRemoved()
                Event:removeTargetEventListenerByType(viewComponent, exitEventName)
                coroutine.resume(removeState)
                removed = true
            end
            Event:registerEventListener(exitEventName, viewComponent, onRemoved)
            viewComponent:removeFromParent()
            if not removed then coroutine.yield() end
        end

        -- do the callback
        if callback then callback() end
    end)

    -- start remove
    coroutine.resume(removeState)    
end

return RemoveLayersCommand