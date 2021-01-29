local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleController)

local SetLastBattleLeaderGun = function(self)
	if CS.GF.Battle.BattleController.renderTexture == nil then
		self:SetLastBattleLeaderGun();
	end
end

util.hotfix_ex(CS.GF.Battle.BattleController,'SetLastBattleLeaderGun',SetLastBattleLeaderGun)
