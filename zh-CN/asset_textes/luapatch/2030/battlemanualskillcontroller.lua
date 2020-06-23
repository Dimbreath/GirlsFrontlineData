local util = require 'xlua.util'
xlua.private_accessible(CS.BattleManualSkillController)
local OnDisplayDisable = function(self)
    self:OnDisplayDisable()
    if self.currentDisplayedCondition ~= nil then
        self:OnDisplay(self.currentDisplayedCondition);
    end
end
util.hotfix_ex(CS.BattleManualSkillController,'OnDisplayDisable',OnDisplayDisable)