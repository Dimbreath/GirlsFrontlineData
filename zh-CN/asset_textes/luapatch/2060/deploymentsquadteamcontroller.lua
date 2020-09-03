local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSquadTeamController)

local CheckCurrentSpotTrans = function(self,target)
	self.currentSpot.spotAction.squadTeamInstanceIds:Remove(self.squadTeamInstanceId);
	target.spotAction.squadTeamInstanceIds:Add(self.squadTeamInstanceId);
	self:Transfer(target);
end

local Complete = function(self)
	self:Complete();
	if self.targetSpot == nil then
		if CS.DeploymentController.Instance:HasTeamCanTrans() then
			CS.DeploymentController.Instance:CheckTeamTrans();
		end
	end
end
util.hotfix_ex(CS.DeploymentSquadTeamController,'CheckCurrentSpotTrans',CheckCurrentSpotTrans)
util.hotfix_ex(CS.DeploymentSquadTeamController,'Complete',Complete)