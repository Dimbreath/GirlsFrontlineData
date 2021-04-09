local util = require 'xlua.util'
xlua.private_accessible(CS.SquadListController)

local InitSquadList = function(self,squadType)
	self:InitSquadList(squadType);
	local scrollRectList = self.transform:Find("SquadListLabelScroller").gameObject:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
	if self.listControllerSangvis.gameObject.activeSelf then
		scrollRectList.content = self.listControllerSangvis.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform))
	else
		scrollRectList.content = self.listControllerFireTeam.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform))
	end
end

util.hotfix_ex(CS.SquadListController,'InitSquadList',InitSquadList)
