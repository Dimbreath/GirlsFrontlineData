local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionMissionBarController)
local ShowUnlockTip = function(self)
    if self.missionInfo.missionType == CS.MissionType.NormalActivity then
        CS.CommonController.LightMessageTips(CS.System.String.Format(CS.Data.GetLang(1480),CS.MissionSelectionActivityController.Instance:GetLastMissionName(self.missionInfo)));
    else
        self:ShowUnlockTip();
    end
end
local UpdateData = function(self,mission,currentMissionType,MSC,missioninfo)
    self:UpdateData(mission,currentMissionType,MSC,missioninfo);
    if self.missionInfo == nil and mission ~= nil then
        self.missionInfo = mission.missionInfo;
    end
end
util.hotfix_ex(CS.MissionSelectionMissionBarController,'ShowUnlockTip',ShowUnlockTip)
util.hotfix_ex(CS.MissionSelectionMissionBarController,'UpdateData',UpdateData)