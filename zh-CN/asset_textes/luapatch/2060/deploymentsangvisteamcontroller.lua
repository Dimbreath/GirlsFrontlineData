local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSangvisTeamController)

local CheckCurrentSpotTrans = function(self,target)
	self.currentSpot.spotAction.sangvisTeamId = 0;
	target.spotAction.sangvisTeamId = self.teamId;
	self:Transfer(target);
end

util.hotfix_ex(CS.DeploymentSangvisTeamController,'CheckCurrentSpotTrans',CheckCurrentSpotTrans)
