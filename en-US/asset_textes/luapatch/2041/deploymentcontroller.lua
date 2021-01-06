local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)
xlua.private_accessible(CS.DeploymentPlanModeController)

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
	if  CS.DeploymentController.Instance ~= nil and CS.GameData.missionAction ~= nil then
		if CS.DeploymentPlanModeController.Instance.listPlan.Count == 0 and CS.DeploymentPlanModeController.Instance.teamRecordPlay.Count == 0 then
			CS.DeploymentPlanModeController.CancelPlan();
		else 	
			CS.DeploymentPlanModeController.ResumePlan();
		end
	end
end

local DeploymentController_GoBattle = function(self)
	local spotaction = CS.GameData.engagedSpot;
	if spotaction ~= nil then
		local i = 0;
		print(spotaction.battleBuildAction.Count)
		while i< spotaction.battleBuildAction.Count do
			local buildAction = spotaction.battleBuildAction[i];
			print(buildAction.buildingInfo.code)
			if buildAction.buildingInfo.code == "Armstrongspiralgun_Griffin" then
				local info = CS.GameData.listSquadInfo:GetDataById(1009);
				if info == nil then
					print("cannotfindSquadInfo 1009")
				end
				local squaduse = CS.Squad(info);
				squaduse.rank = squaduse.maxRank;
				squaduse:UpdateData();
				squaduse.life = 10;
				local squadTeam = CS.SquadTeam(-1,squaduse);
				squadTeam.currentSpotInfo = buildAction.currentSpotAction.spotInfo;
				spotaction.battleSquadTeam:Add(squadTeam);
				spotaction.battleBuildAction:Remove(buildAction);
				print(buildAction.buildingInfo.code.."SelfEffect")
			else
				i = i + 1;
			end
		end
	end	
	self:GoBattle();
end

local DeploymentController_InitField = function(self)
	self:InitField();
	for i = 0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do		
		local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i);
		if spot.buildControl ~= nil then
			spot.buildControl:CheckUseBattleSkill();
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
util.hotfix_ex(CS.DeploymentController,'TriggerClickEnemyEvent',DeploymentController_TriggerClickEnemyEvent)
util.hotfix_ex(CS.DeploymentController,'TriggerClickAllyTeamEvent',DeploymentController_TriggerClickAllyTeamEvent)
util.hotfix_ex(CS.DeploymentController,'RequestFriendTurnHandle',DeploymentController_RequestFriendTurnHandle)
util.hotfix_ex(CS.DeploymentController,'GoBattle',DeploymentController_GoBattle)
util.hotfix_ex(CS.DeploymentController,'InitField',DeploymentController_InitField)
util.hotfix_ex(CS.DeploymentController,'TriggerRefreshBattleMessageEvent',DeploymentController_TriggerRefreshBattleMessageEvent)