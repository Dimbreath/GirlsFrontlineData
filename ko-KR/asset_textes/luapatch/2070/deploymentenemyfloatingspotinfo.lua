local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyFloatingSpotInfo)

local CheckStealTip = function(self)
	self:CheckStealTip();
	if self.stealTip ~= nil and not self.stealTip:isNull() then
		self.stealTip.transform:GetChild(0).gameObject:SetActive(false);
	end
end

util.hotfix_ex(CS.DeploymentEnemyFloatingSpotInfo,'CheckStealTip',CheckStealTip)
