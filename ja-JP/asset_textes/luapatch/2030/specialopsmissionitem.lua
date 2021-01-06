local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialOPSMissionItem)
local Init = function(self,missioninfo)
    self:Init(missioninfo);
    print('SpecialOPSMissionItem_Init');
    if CS.GameData.missionAction == nil or CS.GameData.missionAction.missionInfo.id ~= missioninfo.id then
        if self.missionEventPrize ~= nil and self.mission ~= nil and not self.mission.medal1 and self.mission.counter > 0 then
            self:SetBossBloodGrid(self.transform, self.missionEventPrize.bossHpBars - self.mission.winCount, self.missionEventPrize.bossHpBars, self.mBloodBar, true);
        end
    end
end
util.hotfix_ex(CS.SpecialOPSMissionItem,'Init',Init)