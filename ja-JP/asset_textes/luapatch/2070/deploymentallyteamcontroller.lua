local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamController)

local currentSpot;

local PlayAvgSpot = function()
	CS.DeploymentController.TriggerAVGPointTriggerEvent(currentSpot.spotAction.spotInfo.id);
end

local CheckAVGSpot = function()
	print("添加PlayAvgSpot");
	CS.DeploymentController.Instance:AddAndPlayPerformance(PlayAvgSpot);
end

local Complete = function(self)
	currentSpot = self.currentSpot;
	if self:CanPlayerHandControl() and CS.DeploymentController.Instance.currentSelectedTeam == self then
		CS.DeploymentController.Instance:InsertSomePlayPerformances(CheckAVGSpot);
	end
	self:Complete();
end

local OnPointerDown = function(self,eventData)
	self:OnPointerDown(eventData);
	CS.DeploymentAllyTeamController.time = -1;
end

util.hotfix_ex(CS.DeploymentAllyTeamController,'Complete',Complete)
util.hotfix_ex(CS.DeploymentAllyTeamController,'OnPointerDown',OnPointerDown)

