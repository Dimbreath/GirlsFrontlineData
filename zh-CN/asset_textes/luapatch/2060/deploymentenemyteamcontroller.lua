local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyTeamController)

local CheckUseBuildTip = function(self)
	self:CheckUseBuildTip();
	if self.buildTip ~= nil and not self.buildTip:isNull() then
		self.buildTip.gameObject:SetActive(self.currentSpot.visible);
	end
end

local CheckFriendTip = function(self)
	self:CheckFriendTip();
	if self.yudiTip ~= nil and not self.yudiTip:isNull()  then
		self.yudiTip.gameObject:SetActive(self.currentSpot.visible);
	end	
end

local CheckSpecialCodePos = function(self)
	
end
util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckUseBuildTip',CheckUseBuildTip)
util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckFriendTip',CheckFriendTip)
util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckSpecialCodePos',CheckSpecialCodePos)