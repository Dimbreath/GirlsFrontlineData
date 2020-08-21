local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamController)

local CheckUseBuildTip = function(self)
	self:CheckUseBuildTip();
	if self.buildTip ~= nil and self.buildTip.gameObject ~= nil then
		self.buildTip.gameObject:SetActive(self.currentSpot.visible);
	end
end

local CheckFriendTip = function(self)
	self:CheckFriendTip();
	if self.tip ~= nil and self.tip.gameObject ~= nil then
		self.tip.gameObject:SetActive(self.currentSpot.visible);
	end	
end

util.hotfix_ex(CS.DeploymentAllyTeamController,'CheckUseBuildTip',CheckUseBuildTip)
util.hotfix_ex(CS.DeploymentAllyTeamController,'CheckFriendTip',CheckFriendTip)