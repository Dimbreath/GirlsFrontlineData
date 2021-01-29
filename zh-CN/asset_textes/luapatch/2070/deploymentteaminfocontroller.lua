local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamInfoController)

local RqquestAllyReinforceHandle = function(self,data)
	self:RqquestAllyReinforceHandle(data);
	CS.DeploymentController.TriggerCreateTeamEvent(CS.DeploymentTeamInfoController.currentSelectedSpot, 0, CS.DeploymentController.TeamType.allyTeam, true);
end

util.hotfix_ex(CS.DeploymentTeamInfoController,'RqquestAllyReinforceHandle',RqquestAllyReinforceHandle)