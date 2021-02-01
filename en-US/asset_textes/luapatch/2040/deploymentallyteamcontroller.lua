local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamController)

local DeploymentAllyTeamController_OnDestroy = function(self)
	self:OnDestroy();
	if self.currentSpot.spotAction ~= nil and not self.currentSpot.spotAction.allyTeamInstanceIds:Contains(self.allyTeamInstanceId) then
		for i=0,self.effectSpotAction.Count -1 do
			if self.allyTeam.friendSquadTeam ~= nil then 
				self.effectSpotAction[i].battleSquadTeam:Remove(self.allyTeam.friendSquadTeam);
			elseif self.allyTeam.enemyBuildAction ~= nil then
				 self.effectSpotAction[i].battleBuildAction:Remove(self.allyTeam.enemyBuildAction);
			end
			if self.effectSpotAction[i].spot ~= nil and self.effectSpotAction[i].spot.currentTeam ~= nil then
				self.effectSpotAction[i].spot.currentTeam:CheckSpecialSpotLine();
			end
		end
	end
	self.effectSpotAction:Clear();
end


util.hotfix_ex(CS.DeploymentAllyTeamController,'OnDestroy',DeploymentAllyTeamController_OnDestroy)