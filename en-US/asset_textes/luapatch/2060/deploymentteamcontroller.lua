local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamController)

local Transfer = function(self,target)
	self:Transfer(target);
	CS.DeploymentController.TriggerSwitchAbovePanelEvent(true);
end

util.hotfix_ex(CS.DeploymentTeamController,'Transfer',Transfer)