local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSangvisTeamController)

local CheckCurrentSpotTrans = function(self,target)
	self.currentSpot.spotAction.sangvisTeamId = 0;
	target.spotAction.sangvisTeamId = self.teamId;
	self:Transfer(target);
end

local MoveDirect = function(self,targetspot)
	self:MoveDirect(targetspot);
	if targetspot.currentTeam == nil then
		CS.DeploymentPlanModeController.Instance.enabled = true;
	end
	if targetspot.currentTeam ~= nil and targetspot.currentTeam:CurrentTeamBelong() ~= CS.TeamBelong.friendly then
		CS.DeploymentPlanModeController.Instance.enabled = false;
	end
end

util.hotfix_ex(CS.DeploymentSangvisTeamController,'CheckCurrentSpotTrans',CheckCurrentSpotTrans)
util.hotfix_ex(CS.DeploymentSangvisTeamController,'MoveDirect',MoveDirect)
