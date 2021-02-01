local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentRandomEventController)

local OnClick = function(self)
	if self.checkSpotAction ~= nil then
		self:OnClick();
	else
		self.gameObject:SetActive(false);
	end
end

util.hotfix_ex(CS.DeploymentRandomEventController,'OnClick',OnClick)