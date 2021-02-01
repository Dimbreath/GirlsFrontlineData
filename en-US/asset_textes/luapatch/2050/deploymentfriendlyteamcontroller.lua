local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentFriendlyTeamController)

local DeploymentFriendlyTeamController_Fly = function(self,target,start)
	self:Fly(target,start);
	CS.DeploymentController.TriggerSelectTeam(nil);
end

util.hotfix_ex(CS.DeploymentFriendlyTeamController,'Fly',DeploymentFriendlyTeamController_Fly)
