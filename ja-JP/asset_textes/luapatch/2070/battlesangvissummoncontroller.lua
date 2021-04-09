local util = require 'xlua.util'
xlua.private_accessible(CS.BattleSangvisSummonController)
xlua.private_accessible(CS.GF.Battle.BattleController)

--hottag
local SangvisMeleeSeekMove = function(self)
	if self.mCommonSeekTarget ~= nil and not(CS.GF.Battle.BattleController.Instance.listFriendlyTarget:Contains(self.mCommonSeekTarget)) then
		self.mCommonSeekTarget = nil
		self.status = CS.GF.Battle.CharacterStatus.standby
		return
	end
	self:SangvisMeleeSeekMove()
end
util.hotfix_ex(CS.BattleSangvisSummonController,'SangvisMeleeSeekMove',SangvisMeleeSeekMove)