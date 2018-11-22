
local ContextProxy = class("ContextProxy", FILE.Proxy)

function ContextProxy:getCurrentContext()
	return self.data[#self.data]
end

function ContextProxy:pushContext(context)
	table.insert(self.data, context)
end

function ContextProxy:popContext()
	return table.remove(self.data)
end

function ContextProxy:cleanContext()
	self.data = {}
end

function ContextProxy:getContextCount()
	return #self.data
end


return ContextProxy