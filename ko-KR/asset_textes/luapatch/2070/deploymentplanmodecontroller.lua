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

local _CancelPlan = function(self)
	if CS.GameData.missionAction == nil then
		CS.DeploymentPlanModeController.Instance:UpdateRecordMask();
		CS.DeploymentPlanModeController.Instance:UpdatePlanMark();
		CS.DeploymentPlanModeController.Instance.status = CS.DeploymentPlanModeController.PlanStatus.normal;
		CS.DeploymentUIController.Instance:ShowHideButton(true);
		CS.DeploymentUIController.Instance:SwitchAbovePanel(false);
	else
		self:_CancelPlan();
	end
end
local UpdatePlanMark = function(self)
	for i=0,self.listMarks.Count-1 do
		if self.listMarks[i].gameObject~=nil and not self.listMarks[i].gameObject:isNull() then
			CS.UnityEngine.Object.Destroy(self.listMarks[i].gameObject);
		end
	end
	for i=0,self.masklines.Count-1 do
		if self.masklines[i]~=nil and not self.masklines[i]:isNull() then
			CS.UnityEngine.Object.Destroy(self.masklines[i]);
		end
	end
	self.listMarks:Clear();
	self.masklines:Clear();
	self:UpdatePlanMark();
end
util.hotfix_ex(CS.DeploymentPlanModeController,'PausePlan',PausePlan)
util.hotfix_ex(CS.DeploymentPlanModeController,'Resume',Resume)
util.hotfix_ex(CS.DeploymentPlanModeController,'_CancelPlan',_CancelPlan)
util.hotfix_ex(CS.DeploymentPlanModeController,'UpdatePlanMark',UpdatePlanMark)
