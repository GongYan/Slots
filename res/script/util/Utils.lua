cc.exports.Utils = cc.exports.Utils or {}
local Utils = cc.exports.Utils
local function log(msg, ...)

	msg = msg .. " "
	local args = {...}
	for i,v in ipairs(args) do
		msg = msg .. tostring(v) .. " "
	end
	print(msg)
end
Utils.log = log


local function customShader(node, shaderPath )
	-- local u_dS = -1
	local pProgram  = cc.GLProgram:createWithFilenames(shaderPath .. ".vsh", shaderPath .. ".fsh")  
	local pState = cc.GLProgramState:getOrCreateWithGLProgram(pProgram)
		pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)  
		pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)  
		pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
		pProgram:link() 
		pProgram:updateUniforms() 
		pState:applyUniforms() 
		-- pState:setUniformFloat("u_dS",u_dS)
		node:setGLProgram(pProgram)
end
Utils.customShader = customShader