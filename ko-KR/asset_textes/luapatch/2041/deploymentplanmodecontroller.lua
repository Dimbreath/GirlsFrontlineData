local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPlanModeController)
xlua.private_accessible("DeploymentPlanModeController+Plan")

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

local DeploymentPlanModeController_Play = function(self)
	local playteam = CS.DeploymentController.Instance.playerTeams:Find(function(t)
			return t.teamId == self.teamId;
		end)
	local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataById(self.targetSpotId);
	if playteam ~= nil and spot.currentTeam == nil  and spot.currentHostage == nil  and not CS.DeploymentController.Instance:CheckCanMove(playteam.currentSpot,spot) then
		CS.CommonController.LightMessageTips(CS.Data.GetLang(200128));
		CS.DeploymentPlanModeController.Instance:RemoveTeamPlan(self.teamId);
		CS.DeploymentPlanModeController.Instance:DequeueAndPlay();
	else
		self:Play();
	end
end

local DeploymentPlanModeController_RepeatMoni = function(self)
	if CS.GameData.missionResult.rank == CS.Rank.C then
		self:ReastTeamRecord();
	end
	self:RepeatMoni();
end

util.hotfix_ex(CS.DeploymentPlanModeController,'SaveTeamRecord',DeploymentPlanModeController_SaveTeamRecord)
util.hotfix_ex(CS.DeploymentPlanModeController,'ConvertRecordToPlanStartMission',DeploymentPlanModeController_ConvertRecordToPlanStartMission)
util.hotfix_ex(CS.DeploymentPlanModeController,'ExecutePlan',DeploymentPlanModeController_ExecutePlan)
util.hotfix_ex(CS.DeploymentPlanModeController.Plan,'Play',DeploymentPlanModeController_Play)
util.hotfix_ex(CS.DeploymentPlanModeController,'RepeatMoni',DeploymentPlanModeController_RepeatMoni)