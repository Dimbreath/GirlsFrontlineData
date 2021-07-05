local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamInfoController)

local RqquestAllyReinforceHandle = function(self,data)
	self:RqquestAllyReinforceHandle(data);
	CS.DeploymentController.TriggerCreateTeamEvent(CS.DeploymentTeamInfoController.currentSelectedSpot, 0, CS.DeploymentController.TeamType.allyTeam, true);
end

local CheckTeamSpineShow = function(self,show)
	self:CheckTeamSpineShow(show);
	local sangvis = self.sangvisTransform.gameObject.activeSelf;
	self:ShowCurrentTeamNum(sangvis);
	if not show then
		self.deployNumTip.gameObject:SetActive(false);
	end
end

local SquadSupply = function(spotAction)
	CS.DeploymentTeamInfoController.currentSelectedSpotAction = spotAction;
	CS.DeploymentTeamInfoController.SquadSupply(spotAction);
end
util.hotfix_ex(CS.DeploymentTeamInfoController,'CheckTeamSpineShow',CheckTeamSpineShow)
util.hotfix_ex(CS.DeploymentTeamInfoController,'RqquestAllyReinforceHandle',RqquestAllyReinforceHandle)
util.hotfix_ex(CS.DeploymentTeamInfoController,'SquadSupply',SquadSupply)