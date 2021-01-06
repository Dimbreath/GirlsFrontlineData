local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPlanModeController)
xlua.private_accessible("DeploymentPlanModeController+Plan")

local DeploymentPlanModeController_ResumePlan = function()
	if CS.DeploymentPlanModeController.Instance ~= nil and CS.GameData.missionAction ~= nil then
		if CS.DeploymentPlanModeController.Instance.status == CS.DeploymentPlanModeController.PlanStatus.pause then
			CS.DeploymentPlanModeController.Instance.status = CS.DeploymentPlanModeController.PlanStatus.executing;
		end
		if CS.DeploymentPlanModeController.Instance.status == CS.DeploymentPlanModeController.PlanStatus.executing and CS.DeploymentPlanModeController.Instance.listPlan.Count == 0 and CS.DeploymentPlanModeController.Instance.teamRecordPlay.Count == 0 then
			CS.DeploymentPlanModeController.CancelPlan();
		end
	end
	
end

local DeploymentPlanModeController_Play = function(self)
	local playteam = nil;
	if self.teamData.teamType == CS.DeploymentPlanModeController.TeamType.selfTeam then
		playteam = CS.DeploymentController.Instance.playerTeams:Find(function(t)
			return t.teamId == self.teamData.teamId;
		end)
	elseif self.teamData.teamType == CS.DeploymentPlanModeController.TeamType.sangvisTeam then
		playteam = CS.DeploymentController.Instance.sangvisTeams:Find(function(t)
			return	t.teamId == self.teamData.teamId;
			end)
	elseif self.teamData.teamType == CS.DeploymentPlanModeController.TeamType.squadTeam then
		playteam = CS.DeploymentController.Instance.squadTeams:Find(function(t)
			return	t.squadTeam.squadInstanceId  == self.teamData.teamId;
			end)
	end
	--print(playteam)
	local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataById(self.targetSpotId);		
	if playteam ~= nil and spot.currentTeam == nil  and spot.currentHostage == nil  and not CS.DeploymentController.Instance:CheckCanMove(playteam.currentSpot,spot) then
		CS.CommonController.LightMessageTips(CS.Data.GetLang(200128));
		CS.DeploymentPlanModeController.Instance:RemoveTeamPlanAndPlayNext(self.teamData);
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

util.hotfix_ex(CS.DeploymentPlanModeController,'RepeatMoni',DeploymentPlanModeController_RepeatMoni)
util.hotfix_ex(CS.DeploymentPlanModeController,'ResumePlan',DeploymentPlanModeController_ResumePlan)
util.hotfix_ex(CS.DeploymentPlanModeController.Plan,'Play',DeploymentPlanModeController_Play)