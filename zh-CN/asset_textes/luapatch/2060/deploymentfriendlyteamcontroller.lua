local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentFriendlyTeamController)

local CheckCurrentSpotTrans = function(self,target)
	self.currentSpot.spotAction.friendlyTeamId = 0;
	target.spotAction.friendlyTeamId = self.teamId;
	self:Transfer(target);
end

util.hotfix_ex(CS.DeploymentFriendlyTeamController,'CheckCurrentSpotTrans',CheckCurrentSpotTrans)