local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialMissionSpotController)
local SpecialMissionSpotController_Start = function(self)
	self:Start();
	if self.mission ~= nil and self.mission.missionInfo.id == 10508 then
		local check = self.transform:Find('HornetsNest');
		if check ~= nil then
			check.gameObject:SetActive(true);
		end
	end
end
util.hotfix_ex(CS.SpecialMissionSpotController,'Start',SpecialMissionSpotController_Start)