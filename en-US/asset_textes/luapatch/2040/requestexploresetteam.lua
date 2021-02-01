local util = require 'xlua.util'
xlua.private_accessible(CS.RequestExploreSetTeam)
local SuccessHandleData = function(self,www)
	print('SuccessHandleData');
	self:SuccessHandleData(www);
	if CS.GameData.exploreAction.isTravelling then
		CS.GameData.explorationSetting.nextExploreTime = 0;
	end
end
util.hotfix_ex(CS.RequestExploreSetTeam,'SuccessHandleData',SuccessHandleData)