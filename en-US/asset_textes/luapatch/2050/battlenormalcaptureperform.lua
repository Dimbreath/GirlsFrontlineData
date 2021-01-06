local util = require 'xlua.util'
xlua.private_accessible(CS.BattleNormalCapturePerform)
local DoEnemyEMPAttacked = function(self)
	self:DoEnemyEMPAttacked()
	self:PlaySFX("BT_empcar_impact")
end
util.hotfix_ex(CS.BattleNormalCapturePerform,'DoEnemyEMPAttacked',DoEnemyEMPAttacked)