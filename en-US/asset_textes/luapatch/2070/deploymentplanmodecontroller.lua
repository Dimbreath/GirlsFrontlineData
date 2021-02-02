local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPlanModeController)

local PausePlan = function()
	if CS.DeploymentPlanModeController.Instance ~= nil and CS.DeploymentPlanModeController.Instance.status == CS.DeploymentPlanModeController.PlanStatus.executing then
		CS.DeploymentPlanModeController.Instance.status = CS.DeploymentPlanModeController.PlanStatus.pause;
	end
end

local Resume = function(self)
	if CS.DeploymentController.Instance ~= nil and not CS.DeploymentController.Instance:isNull() then
		if CS.DeploymentController._randomEventController ~= nil and CS.DeploymentController._randomEventController.gameObject.activeSelf then
			return;
		end
	end
	self:Resume();
end

util.hotfix_ex(CS.DeploymentPlanModeController,'PausePlan',PausePlan)
util.hotfix_ex(CS.DeploymentPlanModeController,'Resume',Resume)
