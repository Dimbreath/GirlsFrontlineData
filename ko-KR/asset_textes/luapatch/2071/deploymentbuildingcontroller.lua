local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingController)

local buildAction = function(self)
	if CS.GameData.missionAction ~= nil then		
		local buildAction = CS.GameData.missionAction.listBuildingAction:GetDataById(self.spot.spotInfo.id);
		self.spot.buildingAction = buildAction;
		self.spot.spotAction.buildingAction = buildAction;
		buildAction.buildController = self;
		return buildAction;
	end	
	return self.spot.buildingAction;
end

local Update = function(self)
	if CS.DeploymentController.Instance == nil or CS.DeploymentController.Instance:isNull() then
		return;
	end
	self:Update();
end

local CheckDefender = function(self,playcameramove,time)
	local play = self.lastactiveid ~= self.buildAction.activeOrder;
	self:CheckDefender(playcameramove,time);
	if not playcameramove or not self.buildAction.buildingInfo.cameraMove then
		self:CheckAnim(play, self.lastactiveid);
	end
end

local CheckUseBattleSkill = function(self)
	local defend = self.buildAction.currentDefender;
	self.buildAction.currentDefender = 0;
	self:CheckUseBattleSkill();
	self.buildAction.currentDefender = defend;
	if self.effectSpotAction ~= nil then
		for i=0,self.effectSpotAction.Count-1 do
			local buildaction = self.effectSpotAction[i].battleBuildAction:Find(function(s) return s.spotId == self.buildAction.spotId end);
			if self.buildAction.CanUseBattleSkill then
				if buildaction == nil then
					self.effectSpotAction[i].battleBuildAction:Add(self.buildAction);
				end
			else
				if buildaction ~= nil then
					self.effectSpotAction[i].battleBuildAction:Remove(buildaction);
				end
			end		
			if self.effectSpotAction[i].spot.currentTeam ~= nil and not self.effectSpotAction[i].spot.currentTeam:isNull() then
				self.effectSpotAction[i].spot.currentTeam:CheckSpecialSpotLine();
			end
			if self.effectSpotAction[i].spot.currentTeamTemp ~= nil and not self.effectSpotAction[i].spot.currentTeamTemp:isNull() then
				self.effectSpotAction[i].spot.currentTeamTemp:CheckSpecialSpotLine();
			end
		end
	end
end

util.hotfix_ex(CS.DeploymentBuildingController,'get_buildAction',buildAction)
util.hotfix_ex(CS.DeploymentBuildingController,'Update',Update)
util.hotfix_ex(CS.DeploymentBuildingController,'CheckDefender',CheckDefender)
util.hotfix_ex(CS.DeploymentBuildingController,'CheckUseBattleSkill',CheckUseBattleSkill)
