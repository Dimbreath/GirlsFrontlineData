local util = require 'xlua.util'
xlua.private_accessible(CS.AVGTrigger)

local AVGTrigger_PlayAVG = function(self)
	if CS.System.String.IsNullOrEmpty(self.scriptName) then
		if CS.GameData.missionResult ~= nil then
			CS.DeploymentController.TriggerPlayPerformanceEndEvent(nil);
		end
		CS.DeploymentController.InitBGM();
		return false;
	end
	local script = CS.ResManager.GetObjectByPath("AVGTxt/" .. self.scriptName, ".txt");
	if script == nil then
		if CS.GameData.missionResult ~= nil then
			CS.DeploymentController.TriggerPlayPerformanceEndEvent(nil);
		end
		CS.DeploymentController.InitBGM();
		return false;
	end
	CS.DeploymentPlanModeController.PausePlan();
	CS.AVGController.Instance.transform:SetParent(CS.CommonController.MainCanvas.transform, false);
	CS.AVGController.Instance:InitializeData(script);
	return true;
end

util.hotfix_ex(CS.AVGTrigger,'PlayAVG',AVGTrigger_PlayAVG)