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
	return  self.currentMissionCombination ~= nil and self.currentMissionCombination.useWinStep and not CS.System.String.IsNullOrEmpty(self.currentMissionCombination.win_step);
end

util.hotfix_ex(CS.BuildingAction,'get_CanUseActiveMissionSkill',MissionAction_CanUseActiveMissionSkill)
util.hotfix_ex(CS.MissionInfo,'get_useWinStep',MissionInfo_useWinStep)