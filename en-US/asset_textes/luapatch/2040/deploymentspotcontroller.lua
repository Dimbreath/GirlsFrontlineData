local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSpotController)

local DeploymentSpotController_SquadAEffect = function(self)
	-- body
	local effect = -1;
	if(self.currentTeam ~= nil and self.currentTeam.squadTeam ~= nil) then
		effect = self.currentTeam.squadTeam.squadData.info.nightView;
	end
	return effect;
end


local DeploymentSpotController_BuffEffect = function(self)
	-- body
	local effect = 0;
	if(self.currentTeam ~= nil) then
		for m=0,self.currentTeam.currentListBuffAction.Count - 1 do
			effect = math.max(effect,self.currentTeam.currentListBuffAction[m].nightView);
		end
	end
	if(self.spotAction ~= nil) then
		for m=0,self.spotAction.listSpecialAction.Count - 1 do
			effect = math.max(effect,self.spotAction.listSpecialAction[m].nightView);
		end
	end
	return effect;
end

local DeploymentSpotController_CurrentNightEffect = function(self)
	local effect = -1;
	effect = math.max(effect,self:FriendEffect());
	effect = math.max(effect,self:RadarEffect());
	effect = math.max(effect,DeploymentSpotController_SquadAEffect(self));
	effect = effect + DeploymentSpotController_BuffEffect(self);
	return effect;
end

util.hotfix_ex(CS.DeploymentSpotController,'CurrentNightEffect',DeploymentSpotController_CurrentNightEffect)
util.hotfix_ex(CS.DeploymentSpotController,'SquadAEffect',DeploymentSpotController_SquadAEffect)
util.hotfix_ex(CS.DeploymentSpotController,'BuffEffect',DeploymentSpotController_BuffEffect)