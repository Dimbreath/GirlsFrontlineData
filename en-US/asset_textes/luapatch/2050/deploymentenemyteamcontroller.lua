local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyTeamController)

local DeploymentEnemyTeamController_CheckSpecialCodePos = function(self)
	
end

util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckSpecialCodePos',DeploymentEnemyTeamController_CheckSpecialCodePos)
