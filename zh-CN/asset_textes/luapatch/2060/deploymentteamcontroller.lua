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
end

util.hotfix_ex(CS.DeploymentTeamController,'Transfer',Transfer)
util.hotfix_ex(CS.DeploymentTeamController,'TransferComplete',TransferComplete)