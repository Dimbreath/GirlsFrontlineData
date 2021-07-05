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

local CheckLayer = function()
	CS.DeploymentUIController.Instance:CheckLayer();
	if CS.DeploymentBackgroundController.canClickLayers.Count == 1 then
		local layer = CS.DeploymentBackgroundController.canClickLayers[0];
		CS.DeploymentBackgroundController.Instance:SwitchLayer(layer,nil,true);
	else
		CS.DeploymentController.Instance:AddAndPlayPerformance(nil);
	end
end
local RequestStartTurnHandle = function(self,www)
	self:RequestStartTurnHandle(www);
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckEnemyDie);
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckLayer);
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

local startFriendAllyTeamTurn = function()
	CS.DeploymentController.Instance:RequestFriendAllyTeamTurn();
end

local TriggerFriendAllyTeamTurnEvent = function()
	CS.DeploymentPlanModeController.Instance.enabled = true;	
	CS.DeploymentController.AddAction(startFriendAllyTeamTurn,0.1);
end

local canairborne = function(spot)
	if spot.spotAction.HasTeam then 
		return false;
	end
	if spot.spotAction.isRandom then 
		return false;
	end
	if spot.CannotSee then 
		return false;
	end
	for i=0,spot.spotAction.listSpecialAction.Count-1 do
		local spotaction = spot.spotAction.listSpecialAction[i];
		if spotaction.spotBuffInfo ~= nil and spotaction.spotBuffInfo.noairborne then
			return false;
		end
	end
	if spot.spotAction.buildingAction ~= nil and not spot.spotAction.buildingAction:CheckSpotActive() then 
		return false;
	end
	return true;
end

local cantransfer = function(skill,spot)
	if spot.spotAction.buildingAction ~= nil and not spot.spotAction.buildingAction:CheckSpotActive() then 
		return false;
	end
	return CS.DeploymentController.cantransfer(skill,spot);
end

local CheckColor = function(self)
	return;
end

local GoBattle = function(self)
	self:GoBattle();
	if self.engagedSpot ~= nil then
		if self.engagedSpot.spot.currentTeam ~= nil and not self.engagedSpot.spot.currentTeam:isNull() then
			for i=0,self.engagedSpot.spot.currentTeam.currentListBuffAction.Count-1 do
				local count = self.engagedSpot.spot.currentTeam.currentListBuffAction[i].battleFinishNum;
				self.engagedSpot.spot.currentTeam.currentListBuffAction[i].battleFinishNum = count - 1;
			end
		end
		if self.engagedSpot.spot.currentTeamTemp ~= nil and not self.engagedSpot.spot.currentTeamTemp:isNull() then
			for i=0,self.engagedSpot.spot.currentTeamTemp.currentListBuffAction.Count-1 do
				local count = self.engagedSpot.spot.currentTeamTemp.currentListBuffAction[i].battleFinishNum;
				self.engagedSpot.spot.currentTeamTemp.currentListBuffAction[i].battleFinishNum = count - 1;
			end
		end
	end
end

local SelectSpot = function(self,spot)
	if spot ~= nil and spot.currentTeam ~= nil then
		if self.targetSpot ~= nil and self.targetSpot.currentTeam.allyTeam ~= nil then
			print("allyteam");
			if not CS.System.String.IsNullOrEmpty(self.targetSpot.currentTeam.allyTeam.enemyTeamInfo.enemy_type_display) then
				local num = tonumber(self.targetSpot.currentTeam.allyTeam.enemyTeamInfo.enemy_type_display);
				if num > 100 then
					CS.CommonController.ConfirmBox(CS.Data.GetLang(num), function()
							CS.DeploymentPlanModeController.ResumePlan();
							CS.DeploymentController.TriggerMoveTeamEvent();
							CS.DeploymentController.TriggerCrossMoveEvent(self.targetSpot.gameObject);
							CS.DeploymentController.TriggerRefreshUIEvent();
						end, function()
							CS.DeploymentPlanModeController.CancelPlan();
						end,CS.ConfirmType.Normal,0,true);
					CS.DeploymentPlanModeController.PausePlan();
					return;
				end
			end
		end
	end
	self:SelectSpot(spot);
end

local ConfirmMove = function(self)
	if self.targetSpot.currentTeam ~= nil then
		if self.targetSpot.currentTeam.enemyTeamInfo ~= nil then
			if not CS.System.String.IsNullOrEmpty(self.targetSpot.currentTeam.enemyTeamInfo.enemy_type_display) then
				local num = tonumber(self.targetSpot.currentTeam.enemyTeamInfo.enemy_type_display);
				if num > 100 then
					CS.CommonController.ConfirmBox(CS.Data.GetLang(num), function()
							CS.DeploymentPlanModeController.ResumePlan();
							CS.DeploymentController.TriggerMoveTeamEvent();
							CS.DeploymentController.TriggerCrossMoveEvent(self.targetSpot.gameObject);
							CS.DeploymentController.TriggerRefreshUIEvent();
						end, function()
							CS.DeploymentPlanModeController.CancelPlan();
						end,CS.ConfirmType.Normal,0,true);
					CS.DeploymentPlanModeController.PausePlan();
					return;
				end
			end
		end
		if self.targetSpot.currentTeam.allyTeam ~= nil then
			if not CS.System.String.IsNullOrEmpty(self.targetSpot.currentTeam.allyTeam.enemyTeamInfo.enemy_type_display) then
				local num = tonumber(self.targetSpot.currentTeam.allyTeam.enemyTeamInfo.enemy_type_display);
				if num > 100 then
					CS.CommonController.ConfirmBox(CS.Data.GetLang(num), function()
							CS.DeploymentPlanModeController.ResumePlan();
							CS.DeploymentController.TriggerMoveTeamEvent();
							CS.DeploymentController.TriggerCrossMoveEvent(self.targetSpot.gameObject);
							CS.DeploymentController.TriggerRefreshUIEvent();
						end, function()
							CS.DeploymentPlanModeController.CancelPlan();
						end,CS.ConfirmType.Normal,0,true);
					CS.DeploymentPlanModeController.PausePlan();
					return;
				end
			end
		end
	end	
	self:ConfirmMove();
end
util.hotfix_ex(CS.DeploymentController,'RequestMoveTeamHandle',RequestMoveTeamHandle)
util.hotfix_ex(CS.DeploymentController,'HasTeamCanUse',HasTeamCanUse)
util.hotfix_ex(CS.DeploymentController,'CreateTeam',CreateTeam)
util.hotfix_ex(CS.DeploymentController,'RequestStartTurnHandle',RequestStartTurnHandle)
util.hotfix_ex(CS.DeploymentController,'AnalysisNightSpots',AnalysisNightSpots)
util.hotfix_ex(CS.DeploymentController,'TriggerFriendAllyTeamTurnEvent',TriggerFriendAllyTeamTurnEvent)
util.hotfix_ex(CS.DeploymentController,'canairborne',canairborne)
util.hotfix_ex(CS.DeploymentController,'cantransfer',cantransfer)
util.hotfix_ex(CS.DeploymentController,'CheckColor',CheckColor)
util.hotfix_ex(CS.DeploymentController,'GoBattle',GoBattle)
util.hotfix_ex(CS.DeploymentController,'SelectSpot',SelectSpot)
util.hotfix_ex(CS.DeploymentController,'ConfirmMove',ConfirmMove)

