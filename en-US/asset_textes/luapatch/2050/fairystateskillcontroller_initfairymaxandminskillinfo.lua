local util = require 'xlua.util'
xlua.private_accessible(CS.FairyStateSkillController)

local InitMaxAndMinSkillInfo = function(self)
    self:InitFairyMaxAndMinSkillInfo()

    self.maxLevelMissionSkill = CS.GameData.listMissionSkillCfg:GetDataById(self.fairyInfo.mainSkillGroupId * 100 + 10)
    self.minLevelMissionSkill = CS.GameData.listMissionSkillCfg:GetDataById(self.fairyInfo.mainSkillGroupId * 100 + 1)
end
util.hotfix_ex(CS.FairyStateSkillController,'InitFairyMaxAndMinSkillInfo',InitMaxAndMinSkillInfo)