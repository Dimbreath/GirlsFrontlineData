local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyFormation)
local Hide = function(self)
	self:Hide();
	CS.GF.Battle.BattleController.CloseDeploymentMoni();
end

local ShowEnemyFormation = function(self,currentSpot)
	if currentSpot.currentTeam == nil then
		return;
	end
	self.gameObject:SetActive(true);
	local moniSpotAction = CS.SpotAction();
	moniSpotAction.spotInfo = currentSpot.spotInfo;
	if currentSpot.currentTeam.allyTeam ~= nil then
		moniSpotAction.enemyTeamId = currentSpot.currentTeam.allyTeam.EnemyTeamId;
	elseif currentSpot.currentTeam.enemyTeam ~= nil then
		moniSpotAction.enemyTeamId = currentSpot.currentTeam.enemyTeam.enemyteamId;
	end
	CS.GF.Battle.BattleController.InitDeploymentMoniShow(self.showRamImage, moniSpotAction);	
end

local ShowEnemyFormation = function(self,moniSpotAction)
	self:ShowEnemyFormation(moniSpotAction);	
end

util.hotfix_ex(CS.DeploymentEnemyFormation,'Hide',Hide)
util.hotfix_ex(CS.DeploymentEnemyFormation,'ShowEnemyFormation',ShowEnemyFormation)