local Context = class("Context")

function Context:ctor(data)
	if data then
		self.mediatorClass = data.mediatorClass
		self.viewComponentClass = data.viewComponentClass
	end
	self.data = {}
	self.parent = nil
	self.children = {}
end

function Context:addChild(context)
	if not context then Utils.log("Context:addChild context is nil") end
	if context.parent ~= nil then
		Utils.log("context already has parent")
		return
	end
	context.parent = self
	table.insert(self.children, context)
end

function Context:removeChild(context)
	if not context then Utils.log("Context:removeChild context is nil") end
	for i, v in ipairs(self.children) do
		if v == context then
			context.parent = nil
			return table.remove(self.children, i)
		end
	end
	return nil
end

return Context