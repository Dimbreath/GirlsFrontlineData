local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleController)
local CheckBaseLine = function(self)
    self:CheckBaseLine()
    if not isBattleFinished then
        self:UpdateArmySpeed()
    end
end
local InitBattle = function(self)
    self:InitBattle()
    if self._listFriendlyGun ~= nil then
        local iter = self.listFriendlyGun.listGun:GetEnumerator()
        while iter:MoveNext() do
            iter.Current.gridRecuceCD = CS.Mathf.Min(CS.Data.GetInt("skill_cd_reduction_limit") * 0.01 + 1, iter.Current.gridRecuceCD);
            iter.Current:InitBattleSkill(false)
            iter.Current:InitDynamicPassiveSkillsAndEquipSkills()
        end
        iter = nil
    end
end
util.hotfix_ex(CS.GF.Battle.BattleController,'CheckBaseLine',CheckBaseLine)
util.hotfix_ex(CS.GF.Battle.BattleController,'InitBattle',InitBattle)