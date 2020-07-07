local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingController)

local DeploymentBuildingController_ShowWinTarget = function(self,winType,medal)
	if self.info ~= nil then
		self:ShowWinTarget(winType,medal);
	end
end
local DeploymentBuildingController_CloseWinTarget = function(self,winType)
	if self.info ~= nil then
		self:CloseWinTarget(winType);
	end
end
local DeploymentBuildingController_CheckUseBattleSkill = function(self)
	if self.effectSpotAction == nil and self.spot.spotAction ~= nil then
		self.effectSpotAction = self.spot.spotAction:GetRangeSpotInfo(self.buildAction.CurrentRange.y, self.buildAction.CurrentRange.x);
		--print(self.effectSpotAction.Count..self.spot.spotAction.spotInfo.id);
	end
	self:CheckUseBattleSkill();
end
util.hotfix_ex(CS.DeploymentBuildingController,'ShowWinTarget',DeploymentBuildingController_ShowWinTarget)
util.hotfix_ex(CS.DeploymentBuildingController,'CloseWinTarget',DeploymentBuildingController_CloseWinTarget)
util.hotfix_ex(CS.DeploymentBuildingController,'CheckUseBattleSkill',DeploymentBuildingController_CheckUseBattleSkill)