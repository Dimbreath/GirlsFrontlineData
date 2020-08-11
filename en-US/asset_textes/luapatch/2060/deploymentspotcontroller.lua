local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSpotController)
local UpdateColor = function(self,targetBelong,play)
	self:UpdateColor(targetBelong,play);
	if self.buildControl ~= nil then
		if self:HasFriendlyTeam() then
			self.buildControl.gameObject:SetActive(true);
		else
			self.buildControl.gameObject:SetActive(not self.CannotSee);
		end
	end
end

local CheckPathLine = function(self,play)
	if not self.packageIgnore then
		self:CheckPathLine(play);
	end
end
util.hotfix_ex(CS.DeploymentSpotController,'UpdateColor',UpdateColor)
util.hotfix_ex(CS.DeploymentSpotController,'CheckPathLine',CheckPathLine)