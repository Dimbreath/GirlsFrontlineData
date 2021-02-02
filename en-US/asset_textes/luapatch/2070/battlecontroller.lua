local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleController)

local SetLastBattleLeaderGun = function(self)
	if CS.GF.Battle.BattleController.renderTexture == nil then
		self:SetLastBattleLeaderGun();
	end
end
local SetLastBattleEnemyID = function(self)
	if self:CanRecordCurrentSpot() then
		CS.TargetTrainGameData.instance:SetLastBattleEnemyID(self.enemyTeamidUse)
		if CS.BattleUIPauseController.Instance ~= nil then
			CS.BattleUIPauseController.Instance:ShowCollectionBtn()
		end
	end
end
util.hotfix_ex(CS.GF.Battle.BattleController,'SetLastBattleLeaderGun',SetLastBattleLeaderGun)
util.hotfix_ex(CS.GF.Battle.BattleController,'SetLastBattleEnemyID',SetLastBattleEnemyID)