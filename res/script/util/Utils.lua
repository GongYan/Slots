cc.exports.Utils = cc.exports.Utils or {}

local function log(msg, ...)

	msg = msg .. " "
	local args = {...}
	for i,v in ipairs(args) do
		msg = msg .. tostring(v) .. " "
	end
	print(msg)
end
cc.exports.Utils.log = log