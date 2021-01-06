local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSangvisSkillPanelController)

local DeploymentSangvisSkillPanelController_Start = function(self)
	self:CloseAllSelectTarget();
	self:Start();
end

util.hotfix_ex(CS.DeploymentSangvisSkillPanelController,'Start',DeploymentSangvisSkillPanelController_Start)
