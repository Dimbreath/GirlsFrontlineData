local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyFormation)
local MissionAction_CanUseActiveMissionSkill = function(self)
	self.currentSpotAction = CS.GameData.listSpotAction:GetDataById(self.spotId);
	if self.currentSpotAction == nil then
		self.activeOrder = self.buildingInfo.initial_state;
		return false;
	end
	if self.currentDefender <= 0 then
		self.activeOrder = -1;
		return false;
	end
	if self.buildingInfo.working_special_spot == nil or self.buildingInfo.working_special_spot =='' then
		self.activeOrder = 0;
		return true;
	end
	return self:checkSpecialSpotOr(self.buildingInfo.working_special_spot);	
end

local MissionInfo_useWinStep = function(self)
	if CS.GameData.missionAction ~= nil and CS.GameData.missionAction.winstepids.Count > 0 then
		return true;
	end
	if self.currentMissionCombination ~= nil then 
		return  self.currentMissionCombination.useWinStep and not CS.System.String.IsNullOrEmpty(self.currentMissionCombination.win_step);
	end
	return not CS.System.String.IsNullOrEmpty(CS.GameData.currentSelectedMissionInfo.win_step);
end
local MissionInfo_useWinType = function(self)
	if self.currentMissionCombination ~= nil and self.currentMissionCombination.useWinType then
		return not CS.System.String.IsNullOrEmpty(self.currentMissionCombination.win_type);
	end
	return not CS.System.String.IsNullOrEmpty(self.win_type);
end
local get_squadLimitTeam = function(self)
	if self.currentMissionCombination ~= nil and self.currentMissionCombination.uselimitSquad then
		return self.currentMissionCombination.limitSquad
	else
		return self.limit_squad
	end
end

local CheckSpotAction = function(self,jsonSpotAction)
	self:CheckSpotAction(jsonSpotAction);
	local data = self.transTeamDatas:GetEnumerator();
	while data:MoveNext() do
		local teamData = data.Current.Value;
		local fromSpot = CS.GameData.listSpotAction:GetDataById(teamData.fromSpotId);
		local toSpot = CS.GameData.listSpotAction:GetDataById(teamData.ToSpotId);
		if teamData.personType == 1 or teamData.personType == 2 then
			if fromSpot.friendlyTeamId == 0 then
				toSpot.friendlyTeamId = teamData.personId;
			end
		end
	end
end

local AddDieEnemyCount = function(self,enemyteam,addnum)
	self:AddDieEnemyCount(enemyteam,addnum);
	self.allDieEnemyNum = self.allDieEnemyNum + addnum;
end
util.hotfix_ex(CS.BuildingAction,'get_CanUseActiveMissionSkill',MissionAction_CanUseActiveMissionSkill)
util.hotfix_ex(CS.MissionInfo,'get_useWinStep',MissionInfo_useWinStep)
util.hotfix_ex(CS.MissionInfo,'get_useWinType',MissionInfo_useWinType)
util.hotfix_ex(CS.MissionInfo,'get_squadLimitTeam',get_squadLimitTeam)
util.hotfix_ex(CS.MissionAction,'CheckSpotAction',CheckSpotAction)
util.hotfix_ex(CS.MissionAction,'AddDieEnemyCount',AddDieEnemyCount)