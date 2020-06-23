local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPlanModeController)

local DeploymentPlanModeController_OnLevelWasLoaded = function(self)
	--if(self.listMarks~=nil)	 then
	--	for m=0,self.listMarks.Count - 1 do
	--		if(self.listMarks[m] ~= nil and self.listMarks[m].gameObject ~= nil) then
	--			 CS.UnityEngine.Object.DestroyImmediate(self.listMarks[m].gameObject);
	--		end
	--	end
	--end
	if(self.masklines ~= nil) then
		for m=0,self.masklines.Count - 1 do
			if(self.masklines[m] ~= nil) then
				 CS.UnityEngine.Object.DestroyImmediate(self.masklines[m].gameObject);
			end
		end
	end
	self:OnLevelWasLoaded();
end
local DeploymentPlanModeController_RepeatMoni = function(self)
	if CS.GameData.currentSelectedMissionInfo.costbp > CS.GameData.userInfo.bp then
		CS.DeploymentController.Instance:ReturnLastScene();
	else
		if CS.GameData.missionResult.rank == CS.Rank.C then
			self:ReastTeamRecord();
		end
		self:RepeatMoni();
	end
end
local DeploymentPlanModeController_SaveTeamRecord = function(self)
	self:SaveTeamRecord();
	CS.DeploymentPlanModeController.teamRecords:Clear();
end

local DeploymentPlanModeController_ConvertRecordToPlanStartMission = function(self)
	self:ReadTeamRecord();
	self:ConvertRecordToPlanStartMission();
end

local DeploymentPlanModeController_ExecutePlan = function(self)
	local state = self.status;
	self:ExecutePlan();
	if state == CS.DeploymentPlanModeController.PlanStatus.pause then
		self.status = CS.DeploymentPlanModeController.PlanStatus.pause;
	end
end

util.hotfix_ex(CS.DeploymentPlanModeController,'OnLevelWasLoaded',DeploymentPlanModeController_OnLevelWasLoaded)
util.hotfix_ex(CS.DeploymentPlanModeController,'RepeatMoni',DeploymentPlanModeController_RepeatMoni)
util.hotfix_ex(CS.DeploymentPlanModeController,'SaveTeamRecord',DeploymentPlanModeController_SaveTeamRecord)
util.hotfix_ex(CS.DeploymentPlanModeController,'ConvertRecordToPlanStartMission',DeploymentPlanModeController_ConvertRecordToPlanStartMission)
util.hotfix_ex(CS.DeploymentPlanModeController,'ExecutePlan',DeploymentPlanModeController_ExecutePlan)
