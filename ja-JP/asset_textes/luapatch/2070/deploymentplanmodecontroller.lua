local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPlanModeController)

local PausePlan = function()
	if CS.DeploymentPlanModeController.Instance ~= nil and CS.DeploymentPlanModeController.Instance.status == CS.DeploymentPlanModeController.PlanStatus.executing then
		CS.DeploymentPlanModeController.Instance.status = CS.DeploymentPlanModeController.PlanStatus.pause;
	end
end

util.hotfix_ex(CS.DeploymentPlanModeController,'PausePlan',PausePlan)
