local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPathController)
local OnClickSpotFast = function(self,spot)
	if spot.CanNotEnter then
		return;
	end	
	self:OnClickSpotFast(spot);
end

local getNodeLengthInfo = function(self,node)
	if node.CanNotEnter then
		return CS.System.Int32.MaxValue;
	end
	return self:getNodeLengthInfo(node);
end

local cache = false;
local StartPlan = function(self)
	if CS.DeploymentController.isDeplyment then
		return;	
	end
	self:StartPlan();
	cache = CS.ConfigData.endTurnConfirmation;
	CS.ConfigData.endTurnConfirmation = false;
end
local _CancelPlan = function(self)
	self:_CancelPlan();
	CS.ConfigData.endTurnConfirmation = cache;
end

local InitDeployment = function(self)
	self:InitDeployment();
	self.enabled = false;
end
util.hotfix_ex(CS.DeploymentPlanModeController,'OnClickSpotFast',OnClickSpotFast)
util.hotfix_ex(CS.DeploymentPlanModeController,'getNodeLengthInfo',getNodeLengthInfo)
util.hotfix_ex(CS.DeploymentPlanModeController,'StartPlan',StartPlan)
util.hotfix_ex(CS.DeploymentPlanModeController,'_CancelPlan',_CancelPlan)
util.hotfix_ex(CS.DeploymentPlanModeController,'InitDeployment',InitDeployment)