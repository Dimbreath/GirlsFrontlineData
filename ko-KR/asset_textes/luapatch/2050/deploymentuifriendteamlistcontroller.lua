local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentUIFriendTeamListController)
local Show = function(self)
	self:Show();
	self.listController.gameObject:SetActive(true);
	self.uiHolder:GetUIElement("ScrollViewRect/Scrollbar",typeof(CS.UnityEngine.UI.Scrollbar)).direction = CS.UnityEngine.UI.Scrollbar.Direction.BottomToTop;
end
util.hotfix_ex(CS.DeploymentUIFriendTeamListController,'Show',Show)