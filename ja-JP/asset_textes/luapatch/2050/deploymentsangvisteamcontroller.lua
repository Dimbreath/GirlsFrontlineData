local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSangvisSkillPanelController)

local DeploymentSangvisSkillPanelController_WithDraw = function(self)
	self:WithDraw();
	if CS.GameData.missionAction ~= nil then
		print(self.teamId);
		CS.GameData.missionAction.sangvisteamAmmoMreData:Remove(self.teamId);
	end
end

util.hotfix_ex(CS.DeploymentSangvisTeamController,'WithDraw',DeploymentSangvisSkillPanelController_WithDraw)
