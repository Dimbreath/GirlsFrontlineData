local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamController)

local CheckBuild = function()
	for i=0,CS.GameData.missionAction.listBuildingAction:GetList().Count-1 do
		local buildaction = CS.GameData.missionAction.listBuildingAction:GetDataByIndex(i);
		if buildaction.buildController ~= nil and not buildaction.buildController:isNull() then
			buildaction.buildController:RefreshController(false);
		end
	end
	CS.DeploymentController.Instance:AddAndPlayPerformance(nil);
end

local RequestMoveTeamHandle = function(self,www)
	self:RequestMoveTeamHandle(www);
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckBuild);
end

local HasTeamCanUse = function(self,spot)
	if spot.type == CS.SpotType.HeavyDTA then
		for i=0,CS.GameData.listSquad.Count-1 do
			local squad = CS.GameData.listSquad:GetDataByIndex(i);
			if squad.info.infoType == CS.SquadInfoCategory.fireTeam and squad.rank>0 then
				if self.squadTeams:Find(function(t)
						return t.squadTeam.squadData == squad;
					end) == nil then
					return true;
				end
			end
		end
	end
	return  self:HasTeamCanUse(spot);
end

local CreateTeam = function(self,selectedSpot,teamId,teamType,grow,growtype)
	if teamType == CS.DeploymentController.TeamType.allyTeam then
		if selectedSpot.spotAction ~= nil  and teamId == 0 then
			for i=0,selectedSpot.spotAction.allyTeamInstanceIds.Count-1 do
				local id = selectedSpot.spotAction.allyTeamInstanceIds[i];
				local allyTeam = CS.GameData.missionAction.listAllyTeams:GetDataById(id);
				if allyTeam.allyTeamController ~= nil and not allyTeam.allyTeamController:isNull() then
					return;
				end
			end
		end
	end
	self:CreateTeam(selectedSpot,teamId,teamType,grow,growtype);
end

local CheckEnemyDie = function()
	CS.DeploymentController.Instance:CheckBuildCastSkillOnDeath();
end
local RequestStartTurnHandle = function(self,www)
	self:RequestStartTurnHandle(www);
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckEnemyDie);
end
local AnalysisNightSpots = function(self,data,playSpotAnim,currentBelong,isSurrend)
	self:AnalysisNightSpots(data,playSpotAnim,currentBelong,isSurrend);
	for i=0,CS.GameData.listSpotAction.Count-1 do
		local spotAction = CS.GameData.listSpotAction:GetDataByIndex(i);
		if CS.DeploymentBackgroundController.Instance.spotTemp:ContainsKey(spotAction.spotInfo.id) then
			if CS.GameData.missionAction.spotid_TransBelongInfo:ContainsKey(spotAction.spotInfo.id) then
				CS.GameData.missionAction.spotid_TransBelongInfo[spotAction.spotInfo.id] = CS.DeploymentBackgroundController.Instance.spotTemp[spotAction.spotInfo.id];
			end
		end
	end
end
util.hotfix_ex(CS.DeploymentController,'RequestMoveTeamHandle',RequestMoveTeamHandle)
util.hotfix_ex(CS.DeploymentController,'HasTeamCanUse',HasTeamCanUse)
util.hotfix_ex(CS.DeploymentController,'CreateTeam',CreateTeam)
util.hotfix_ex(CS.DeploymentController,'RequestStartTurnHandle',RequestStartTurnHandle)
util.hotfix_ex(CS.DeploymentController,'AnalysisNightSpots',AnalysisNightSpots)


