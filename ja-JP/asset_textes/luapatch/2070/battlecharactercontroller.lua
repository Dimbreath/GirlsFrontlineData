local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleCharacterController)
local TauntedTarget_Get = function(self)	
	if self.listTargetInRange == nil then
		return nil
	else
		return self.tauntedTarget
	end
end
util.hotfix_ex(CS.GF.Battle.BattleCharacterController,'get_tauntedTarget',TauntedTarget_Get)