local util = require 'xlua.util'
xlua.private_accessible(CS.BattleEnemyCharacterController)
local DefaultScout = function(self)
    if self.status == CS.GF.Battle.CharacterStatus.fighting then
        self.gun.range = self.gun.range + 1
    end
    self:DefaultScout()
    if self.status == CS.GF.Battle.CharacterStatus.fighting then
        self.gun.range = self.gun.range - 1
    end
end
util.hotfix_ex(CS.BattleEnemyCharacterController,'DefaultScout',DefaultScout)