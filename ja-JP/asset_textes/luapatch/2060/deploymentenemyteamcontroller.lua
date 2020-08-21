local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyTeamController)

local CheckUseBuildTip = function(self)
	self:CheckUseBuildTip();
	if self.buildTip ~= nil and self.buildTip.gameObject ~= nil then
		self.buildTip.gameObject:SetActive(self.currentSpot.visible);
	end
end

local CheckFriendTip = function(self)
	self:CheckFriendTip();
	if self.yudiTip ~= nil and self.yudiTip.gameObject ~= nil then
		self.yudiTip.gameObject:SetActive(self.currentSpot.visible);
	end	
end

util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckUseBuildTip',CheckUseBuildTip)
util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckFriendTip',CheckFriendTip)