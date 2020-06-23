local util = require 'xlua.util'

local effection = nil;
local DeploymentEnemyInfo_ShowSpotInfo = function(self,spot)
	self:ShowSpotInfo(spot);
	if spot.currentTeam ~= nil and spot.spotAction ~= nil and spot.currentTeam.allyTeam ~= nil then
		effection =  spot.currentTeam.effectSpotAction;
		for i = 0, effection.Count-1 do
			effection[i].spot:ShowSquadRangeTip();
		end
	end
end

local DeploymentEnemyInfo_Hide = function(self)
	self:Hide();
	if effection ~= nil then
		for i = 0, effection.Count-1 do
			effection[i].spot:CloseSquadRangeTip();
		end
	end
end

util.hotfix_ex(CS.DeploymentEnemyInfo,'ShowSpotInfo',DeploymentEnemyInfo_ShowSpotInfo)
util.hotfix_ex(CS.DeploymentEnemyInfo,'Hide',DeploymentEnemyInfo_Hide)