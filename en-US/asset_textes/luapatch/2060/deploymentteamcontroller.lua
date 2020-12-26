local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamController)

local Transfer = function(self,target)
	--target.spotAction:MoveHostageDataToSpotAction(self.currentSpot.spotAction);
	self:Transfer(target);
	CS.DeploymentController.TriggerSwitchAbovePanelEvent(true);
end

local TransferComplete = function(self)
	self:TransferComplete();
	CS.DeploymentController.TriggerRefreshUIEvent();
	if self.squadTeam ~= nil then
		if self.currentSpot.currentTeam ~= nil and self.currentSpot.currentTeamTemp ~= nil then
			self.currentSpot.currentTeamTemp = self.currentSpot.currentTeam;
			self.currentSpot.currentTeam = self;
		end
	end
end

local TransferBefore = function(self)
	self:TransferBefore();
	if self.last.buildControl ~= nil then
		self.last.buildControl:RefreshController();
	end
end
local Die = function(self)
	self:Die();
	if CS.DeploymentController.Instance.currentSelectedTeam ~= nil and not CS.DeploymentController.Instance.currentSelectedTeam:isNull() then
		print("重新计算当前技能")
		CS.DeploymentUIController.Instance:OnSelectTeamSkillUI(CS.DeploymentController.Instance.currentSelectedTeam);
	end
end
util.hotfix_ex(CS.DeploymentTeamController,'Transfer',Transfer)
util.hotfix_ex(CS.DeploymentTeamController,'TransferBefore',TransferBefore)
util.hotfix_ex(CS.DeploymentTeamController,'TransferComplete',TransferComplete)
util.hotfix_ex(CS.DeploymentTeamController,'Die',Die)