local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentFloatingTeamInfo)

local DeploymentFloatingTeamInfo_UpdateInfo = function(self)
	if self.teamId<0 and CS.GameData.missionAction == nil then
		return;
	else
		self:UpdateInfo();
	end
end

util.hotfix_ex(CS.DeploymentFloatingTeamInfo,'UpdateInfo',DeploymentFloatingTeamInfo_UpdateInfo)
