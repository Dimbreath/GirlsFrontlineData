local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyTeamController)

local DeploymentEnemyTeamController_Start = function(self)
	self:Start();
	if self.spineHolder ~= nil and self.spineHolder.gameObject.name == "Thunder(Clone)" then 
		self.waitoffset = CS.UnityEngine.Vector2(0,130);
	end	
end

local DeploymentEnemyTeamController_OnDestroy = function(self)
	self:OnDestroy();
	if CS.DeploymentController.Instance ~= nil and not CS.DeploymentController.Instance:isNull() then
		CS.DeploymentController.Instance.enemyTeams:Remove(self);
	end
end

util.hotfix_ex(CS.DeploymentEnemyTeamController,'Start',DeploymentEnemyTeamController_Start)
util.hotfix_ex(CS.DeploymentEnemyTeamController,'OnDestroy',DeploymentEnemyTeamController_OnDestroy)