local util = require 'xlua.util'
xlua.private_accessible(CS.RequestExploreGetEvent)
local Request = function(self)
	local cacheTime = CS.GameData.exploreAction.startTime;
	CS.GameData.exploreAction.startTime = CS.GameData.explorationSetting.nextAffairTime - 4;
	self:Request();
	CS.GameData.exploreAction.startTime = cacheTime;
	cacheTime = nil;
end
local SuccessHandleData = function(self,www)
	local jsonData = CS.ConnectionController.DecodeAndMapJson(www.text);
	local listNew = CS.ExploreAffairArchive.DecodeAffairs(jsonData:GetValue("event_list"));
	for i=0,listNew.Count - 1 do
		if not CS.GameData.exploreAction.listAffairArchive:ContainsKey(listNew[i].time) then
			CS.GameData.exploreAction.listAffairArchive:Add(listNew[i]);
		end
	end
	CS.GameData.explorationSetting.nextAffairTime = jsonData:GetValue("next_time").Int + 3; -- +3秒容错;
	self.isPrize = jsonData:GetValue("is_prize").Int ~= 0;
	jsonData = nil;
	listNew = nil;
end
util.hotfix_ex(CS.RequestExploreGetEvent,'Request',Request)
xlua.hotfix(CS.RequestExploreGetEvent,'SuccessHandleData',SuccessHandleData)