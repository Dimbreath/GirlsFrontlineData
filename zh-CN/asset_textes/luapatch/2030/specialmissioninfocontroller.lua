local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialMissionInfoController)
local ShowNewReward = function(self)
    self:ShowNewReward()
    local parent = self.RewardBg:Find("IconScrollView/Rect")
    if parent.childCount >= 3 then
        local getIconHard = parent:GetChild(2):Find("GetIcon").gameObject;
        if getIconHard.activeSelf then
            parent:GetChild(1):Find("GetIcon").gameObject:SetActive(true);
            self.ClearwhiteTag.gameObject:SetActive(true);
            self.BossList.gameObject:SetActive(false);
        end
    end
end
util.hotfix_ex(CS.SpecialMissionInfoController,'ShowNewReward',ShowNewReward)