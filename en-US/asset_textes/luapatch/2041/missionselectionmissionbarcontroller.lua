local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionMissionBarController)

local MissionSelection_ShowUnlockTip = function(self)
	if self.missionInfo.missionType == CS.MissionType.simulation and self.missionInfo.sub == 1 then
		CS.CommonController.LightMessageTips(CS.System.String.Format(CS.Data.GetLang(40233),"20"));
	elseif self.missionInfo.missionType == CS.MissionType.NormalActivity then
		CS.CommonController.LightMessageTips(CS.System.String.Format(CS.Data.GetLang(40234),CS.MissionSelectionActivityController.Instance:GetLastMissionName(self.missionInfo)));
	else 	
		self:ShowUnlockTip();
	end
end
util.hotfix_ex(CS.MissionSelectionMissionBarController,'ShowUnlockTip',MissionSelection_ShowUnlockTip)