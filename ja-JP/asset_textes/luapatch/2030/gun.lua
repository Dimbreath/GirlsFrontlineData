local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.Gun)
local temp
local GetAtkPoint = function(self,isNight,isFullLife,basePoint,team,countFairy,spotAction)
    if team == nil then
        team = self.team
    end
    if team ~= nil and team.fairy ~= nil then
        temp = self.criHarmRate
        self.criHarmRate = self.criHarmRate + team:GetFairyCritDamage(self)
    end
    local p = self:GetAtkPoint(isNight,isFullLife,basePoint,team,countFairy,spotAction)
    if team ~= nil and team.fairy ~= nil then
        self.criHarmRate = temp
        temp = nil
    end
    return p
end
util.hotfix_ex(CS.GF.Battle.Gun,'GetAtkPoint',GetAtkPoint)