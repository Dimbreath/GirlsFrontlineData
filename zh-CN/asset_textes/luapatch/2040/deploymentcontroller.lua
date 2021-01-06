local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)

local DeploymentController_InitField = function(self)
	self:InitField();
	for i=0, CS.DeploymentBackgroundController.Instance.listSpot.Count -1 do
		local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i);
		if spot.spotAction ~= nil then
			spot.spotAction.battleSquadTeam:Clear();
			spot.spotAction.battleBuildAction:Clear();;
		end
	end
end

local DeploymentController_CanSupply = function(spotAction)
	if spotAction.transform ~= nil then
		return CS.DeploymentController.CanSupply(spotAction);
	end
	if spotAction.limitCanSupply then
		return true;
	else
		return CS.DeploymentController.CanSupply(spotAction);
	end	
end

local  DeploymentController_DeleteUnUseEnemys = function(self)
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count -1 do
		local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i);
		if not spot.Show and spot.currentTeam ~= nil and not spot.currentTeam.gameObject:isNull() then
			if spot.currentTeam.allyTeam == nil or spot.currentTeam.allyTeam.enemyBuildAction == nil then
				CS.UnityEngine.Object.DestroyImmediate(spot.currentTeam.gameObject);
				spot.currentTeam = nil;
				if spot.spotAction ~= nil then
					spot.spotAction:EnemyDataClear();
					spot.spotAction.allyTeamInstanceIds:Clear();
				end
			end
		end
	end
end

local DeploymentController_TriggerClickEnemyEvent = function(team)
	--print (CS.DeploymentPlanModeController.Instance.status)
	if CS.DeploymentPlanModeController.Instance.status ~= CS.DeploymentPlanModeController.PlanStatus.executing then
		if CS.UnityEngine.Input.touchCount > 1 then			
			return
		end
		CS.DeploymentUIController.Instance:CloseAllTipEffect();		
		if CS.DeploymentController.ClickEnemyEvent ~= nil then	
			CS.DeploymentController.ClickEnemyEvent(team);
		end
	else
		CS.DeploymentController.Instance:ClickEnemy(team);
		if team.enemyTeamInfo.showHardDefeat then
			CS.DeploymentPlanModeController:PausePlan();
		elseif team.currentSpot.spotAction.battleFriendlyEffect == false and team.hasDefFoolEnemy then
			CS.DeploymentPlanModeController:PausePlan();
		end
	end
end

local DeploymentController_TriggerClickAllyTeamEvent = function(team)
	if CS.DeploymentPlanModeController.Instance.status ~= CS.DeploymentPlanModeController.PlanStatus.executing then
		if CS.UnityEngine.Input.touchCount > 1 then			
			return
		end
		CS.DeploymentUIController.Instance:CloseAllTipEffect();		
		if CS.DeploymentController.ClickAllyTeamEvent ~= nil then			
			CS.DeploymentController.ClickAllyTeamEvent(team);
		end
	else
		CS.DeploymentController.Instance:ClickAllyTeam(team);
		if team.allyTeam.ShowEnemyHardTip then
			CS.DeploymentPlanModeController:PausePlan();
		elseif team.currentSpot.spotAction.battleFriendlyEffect == false and team.allyTeam.hasDefFoolEnemy then
			CS.DeploymentPlanModeController:PausePlan();
		end	
	end
end

local DeploymentController_RequestFriendTurnHandle = function(self,data)
	if CS.GameData.currentSelectedMissionInfo.specialType == CS.MapSpecialType.Night then
		self:AnalysisNightEnemy(data.jsonData, false);
	end
	self:RequestFriendTurnHandle(data);
end

local DeploymentController_TriggerAVGFinishEvent = function()
	CS.DeploymentController.TriggerAVGFinishEvent();
	if CS.DeploymentController.Instance ~= nil and CS.GameData.missionAction ~= nil then
		if CS.DeploymentPlanModeController.Instance.listPlan.Count == 0 and CS.DeploymentPlanModeController.Instance.teamRecordPlay.Count == 0 then
			CS.DeploymentPlanModeController.CancelPlan();
		else 	
			CS.DeploymentPlanModeController.ResumePlan();
		end
	end
end

local DeploymentController_TriggerRefreshBattleMessageEvent = function(message,once)
	if message == "重型机场进入可用状态" then
		message = CS.Data.GetLang(30078);
	end
	CS.DeploymentController.TriggerRefreshBattleMessageEvent(message,once);
end

util.hotfix_ex(CS.DeploymentController,'TriggerAVGFinishEvent',DeploymentController_TriggerAVGFinishEvent)
util.hotfix_ex(CS.DeploymentController,'InitField',DeploymentController_InitField)
util.hotfix_ex(CS.DeploymentController,'CanSupply',DeploymentController_CanSupply)
--util.hotfix_ex(CS.DeploymentController,'ClickEnemy',DeploymentController_ClickEnemy)
--util.hotfix_ex(CS.DeploymentController,'ClickAllyTeam',DeploymentController_ClickAllyTeam)
util.hotfix_ex(CS.DeploymentController,'TriggerClickEnemyEvent',DeploymentController_TriggerClickEnemyEvent)
util.hotfix_ex(CS.DeploymentController,'TriggerClickAllyTeamEvent',DeploymentController_TriggerClickAllyTeamEvent)
util.hotfix_ex(CS.DeploymentController,'RequestFriendTurnHandle',DeploymentController_RequestFriendTurnHandle)
--util.hotfix_ex(CS.DeploymentController,'DeleteUnUseEnemys',DeploymentController_DeleteUnUseEnemys)
util.hotfix_ex(CS.DeploymentController,'TriggerRefreshBattleMessageEvent',DeploymentController_TriggerRefreshBattleMessageEvent)