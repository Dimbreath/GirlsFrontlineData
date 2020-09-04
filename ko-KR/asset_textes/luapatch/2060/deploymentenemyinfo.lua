local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyInfo)

local ShowEnemyAISpot = function(self,enemyTeam)
	if enemyTeam.enemyai == 101 then
		CS.DeploymentController.Instance:ShowPatrolInfo(enemyTeam.enemyaiInfo);
	elseif enemyTeam.enemyai == 102 then
		CS.DeploymentController.Instance:ShowGuardInfo(enemyTeam.enemyaiInfo);		
	end
end
local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("Right/Info/Building/Belong"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220064);
end

util.hotfix_ex(CS.DeploymentEnemyInfo,'ShowEnemyAISpot',ShowEnemyAISpot)
util.hotfix_ex(CS.DeploymentEnemyInfo,'InitUIElements',InitUIElements)