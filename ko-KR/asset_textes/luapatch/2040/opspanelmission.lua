local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMission)

local OPSPanelMission_ShowTime = function(self)
	if self.showTxt ~= nil then 
		self.showTxt.text = CS.GameData.GetRestTime(CS.OPSConfig.tomorrowTime);
	end
end

util.hotfix_ex(CS.OPSPanelMission,'ShowTime',OPSPanelMission_ShowTime)