local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamInfoController)

local RqquestAllyReinforceHandle = function(self,data)
	self:RqquestAllyReinforceHandle(data);
	CS.DeploymentController.TriggerCreateTeamEvent(CS.DeploymentTeamInfoController.currentSelectedSpot, 0, CS.DeploymentController.TeamType.allyTeam, true);
end

local CheckTeamSpineShow = function(self,show)
	self:CheckTeamSpineShow(show);
	local otherlimit = CS.DeploymentTeamInfoController.currentSelectedSpot ~= nil and CS.DeploymentTeamInfoController.currentSelectedSpot.currentTeam == nil;
	local teamlimit = CS.GameData.currentSelectedMissionInfo.sangvisLimitTeam > 0 or CS.GameData.currentSelectedMissionInfo.totalTeamLimit >0;
	self.deployNumTip.gameObject:SetActive(show and teamlimit and otherlimit);
end

util.hotfix_ex(CS.DeploymentTeamInfoController,'CheckTeamSpineShow',CheckTeamSpineShow)
util.hotfix_ex(CS.DeploymentTeamInfoController,'RqquestAllyReinforceHandle',RqquestAllyReinforceHandle)