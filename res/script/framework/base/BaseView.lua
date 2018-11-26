local BaseView = class("BaseView")

function BaseView:loadCSB(csb_path,ui_name)
	return Tools.UiTools.loadCSB(csb_path,ui_name)
end

function BaseView:seekNodeByName(rootNode, name)
	return Tools.UiTools.seekNodeByName(rootNode,name)
end

return BaseView