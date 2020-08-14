local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyFormation)
local Hide = function(self)
	self:Hide();
	CS.GF.Battle.BattleController.CloseDeploymentMoni();
end

util.hotfix_ex(CS.DeploymentEnemyFormation,'Hide',Hide)