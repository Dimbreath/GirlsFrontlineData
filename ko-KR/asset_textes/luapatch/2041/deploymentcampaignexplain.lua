local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentCampaignExplain)

local DeploymentCampaignExplain_ShowOldMedal = function(self)
	if CS.GameData.currentSelectedMissionInfo.missionWinTypes.Count > 0 then
		local type = CS.GameData.currentSelectedMissionInfo.missionWinTypes[0];
		if type == 11 then
			CS.GameData.currentSelectedMissionInfo.missionWinTypes[0] = 2;
			self:ShowOldMedal();
			CS.GameData.currentSelectedMissionInfo.missionWinTypes[0] = 11;
		else
			self:ShowOldMedal();
		end
	else
		self:ShowOldMedal();
	end
	
end

util.hotfix_ex(CS.DeploymentCampaignExplain,'ShowOldMedal',DeploymentCampaignExplain_ShowOldMedal)
