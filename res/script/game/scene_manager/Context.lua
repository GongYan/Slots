local Context = class("Context")

function Context:ctor(data)
	if data then
		self.mediatorClass = data.mediatorClass
		self.viewClass = data.viewClass
	end
	self.data = {}
	self.parent = nil
	self.children = {}
end

function Context:addChild(context)
	if not context then Tools.log("Context:addChild context is nil") end
	if context.parent ~= nil then
		Tools.log("context already has parent")
		return
	end
	context.parent = self
	table.insert(self.children, context)
end

function Context:removeChild(context)
	if not context then Tools.log("Context:removeChild context is nil") end
	for i, v in ipairs(self.children) do
		if v == context then
			context.parent = nil
			return table.remove(self.children, i)
		end
	end
	return nil
end

function Context:extendData( extend_data )
	if not extend_data or not next(extend_data) then return end
	for k, v in pairs(extend_data) do
		self.data[k] = v
	end
end

function Context:getContextByMediatorName( mediatorName )
	if not mediatorName or mediatorName == "" then return end
	for _, context in ipairs(self.children) do
		if context.mediatorClass.__name == mediatorName then
			return context
		end
	end
	return nil
end

return Context