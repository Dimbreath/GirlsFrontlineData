local util = require 'xlua.util'
xlua.private_accessible(CS.DormUIController)
local OnPanelInit = function(self,name)
	self:OnPanelInit(name);
	if name == "VisitNode" then
		self.transform:Find("VisitNode/BoarderTop/overlay").gameObject:SetActive(false);
	end
end
util.hotfix_ex(CS.DormUIController,'OnPanelInit',OnPanelInit)