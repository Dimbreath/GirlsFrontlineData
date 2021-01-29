local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentFriendlyTeamController)

local Complete = function(self,Complete)
	self:Complete();
	if CS.DeploymentController.Instance.currentSelectedTeam ~= self and CS.DeploymentController.Instance.exchanedSelectedTeam ~= self then
		CS.DeploymentController.TriggerPlayPerformanceEndEvent(nil);
	end
end

util.hotfix_ex(CS.DeploymentFriendlyTeamController,'Complete',Complete)