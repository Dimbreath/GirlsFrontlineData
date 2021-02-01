local util = require 'xlua.util'
xlua.private_accessible(CS.FormationFairyLabelController)
local Init = function(self,...)
	self:Init(...);
	if self.levelName == "Deployment" then
		self.goDetail:SetActive(false);
		self.btnDetail.gameObject:SetActive(false);
	end
end
util.hotfix_ex(CS.FormationFairyLabelController,'Init',Init)
