local UiTools = {}

-- start --
--------------------------------
-- @class function seekNodeByName
-- @description 深度遍历查找节点
-- @param rootNode 根节点
-- @param nodeName 查找节点名称
-- @return 查找到的节点
-- end --
function UiTools.seekNodeByName(rootNode, name)
	if not rootNode or not name then
		return nil
	end

	if rootNode:getName() == name then
		return rootNode
	end

	local children = rootNode:getChildren()
	if not children or #children == 0 then
		return nil
	end
	for i, parentNode in ipairs(children) do
		local childNode = UiTools.seekNodeByName(parentNode, name)
		if childNode then
			return childNode
		end
	end

	return nil
end

function UiTools.loadCSB(csb_path,ui_name)
	local csbNode = cc.CSLoader:createNode(csb_path)
	ccui.Helper:doLayout(csbNode)
	if ui_name then
		csbNode:setName(ui_name)
	end
	return csbNode
end

return UiTools