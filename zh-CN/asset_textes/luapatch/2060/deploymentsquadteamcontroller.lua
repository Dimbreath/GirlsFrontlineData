local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSquadTeamController)

local CheckCurrentSpotTrans = function(self,target)
	self.currentSpot.spotAction.squadTeamInstanceIds:Remove(self.squadTeamInstanceId);
	target.spotAction.squadTeamInstanceIds:Add(self.squadTeamInstanceId);
	self:Transfer(target);
end

util.hotfix_ex(CS.DeploymentSquadTeamController,'CheckCurrentSpotTrans',CheckCurrentSpotTrans)