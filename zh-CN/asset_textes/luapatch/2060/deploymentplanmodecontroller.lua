local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPathController)
xlua.private_accessible(CS.DeploymentUIController)
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
	print("StartPlan"..tostring(CS.ConfigData.endTurnConfirmation));
end
local _CancelPlan = function(self)
	self:_CancelPlan();
	CS.ConfigData.endTurnConfirmation = cache;
	print("_CancelPlan"..tostring(CS.ConfigData.endTurnConfirmation));
	CS.DeploymentUIController.Instance:SwitchAbovePanel(false);
end

local InitDeployment = function(self)
	self:InitDeployment();
	self.enabled = false;
	if self.status == CS.DeploymentPlanModeController.PlanStatus.pause then
		self.status = CS.DeploymentPlanModeController.PlanStatus.wait;
	end
end

local planPlay = function()
	CS.DeploymentPlanModeController.Instance:Play();
end

local DequeueAndPlay = function(self)
	self:SavePlayRecord();
	if CS.GameData.missionAction == nil then
		self:CancelPlan();
		return;
	end
	self:UpdatePlanMark();
	if self.status == CS.DeploymentPlanModeController.PlanStatus.pause then
		return;
	end
	self.status = CS.DeploymentPlanModeController.PlanStatus.wait;
	CS.DeploymentController.AddAction(planPlay,0.001);
	CS.DeploymentUIController.Instance:SwitchAbovePanel(true);
	--self:Play();
end

local Resume = function(self)
	if CS.GameData.engagedSpot ~= nil then
		return;
	end
	if self.listPlan.Count > 0 or self.teamRecordPlay.Count > 0 then
		self.status = CS.DeploymentPlanModeController.PlanStatus.executing;
		DequeueAndPlay(self);
	else
		_CancelPlan(self);
	end
end
util.hotfix_ex(CS.DeploymentPlanModeController,'OnClickSpotFast',OnClickSpotFast)
util.hotfix_ex(CS.DeploymentPlanModeController,'getNodeLengthInfo',getNodeLengthInfo)
util.hotfix_ex(CS.DeploymentPlanModeController,'StartPlan',StartPlan)
util.hotfix_ex(CS.DeploymentPlanModeController,'_CancelPlan',_CancelPlan)
util.hotfix_ex(CS.DeploymentPlanModeController,'InitDeployment',InitDeployment)
util.hotfix_ex(CS.DeploymentPlanModeController,'DequeueAndPlay',DequeueAndPlay)
util.hotfix_ex(CS.DeploymentPlanModeController,'Resume',Resume)