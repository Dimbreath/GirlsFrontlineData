local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)

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
		print("判断");
		if self.targetSpot.currentTeam.enemyTeamInfo ~= nil then
			print("enemyteam");
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
	self:ConfirmMove();
end
util.hotfix_ex(CS.DeploymentController,'GoBattle',GoBattle)
util.hotfix_ex(CS.DeploymentController,'SelectSpot',SelectSpot)
util.hotfix_ex(CS.DeploymentController,'ConfirmMove',ConfirmMove)
