local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamInfoController)

local SquadSupply = function(spotAction)
	CS.DeploymentTeamInfoController.currentSelectedSpotAction = spotAction;
	CS.DeploymentTeamInfoController.SquadSupply(spotAction);
end

local CheckTeamSpineShow = function(self,show)
	self:CheckTeamSpineShow(show);
	if not show then
		self.deployNumTip.gameObject:SetActive(false);
	else
		local sangvis = self.sangvisTransform.gameObject.activeSelf;
		self:ShowCurrentTeamNum(sangvis);
	end
end

util.hotfix_ex(CS.DeploymentTeamInfoController,'SquadSupply',SquadSupply)
util.hotfix_ex(CS.DeploymentTeamInfoController,'CheckTeamSpineShow',CheckTeamSpineShow)