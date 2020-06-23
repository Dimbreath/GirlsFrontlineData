local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.Gun)
local temp
local InitBattleSkill = function(self,missionEnd,forceStartCD)
    if forceStartCD ~= nil then 
        self:InitBattleSkill(missionEnd, forceStartCD);
    else
        self:InitBattleSkill(missionEnd);
        local iter = self.equipList:GetEnumerator();
        while iter:MoveNext() do
            if iter.Current.info.skill ~= 0 then
                self:GetSkill(CS.GF.Battle.enumSkill.eNormal).id = iter.Current.info.skill;
            end
        end
    end
end
util.hotfix_ex(CS.GF.Battle.Gun,'InitBattleSkill',InitBattleSkill)