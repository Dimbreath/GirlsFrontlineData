local util = require 'xlua.util'
xlua.private_accessible(CS.AVGTrigger)
local AVGPointTriggerEvent = function(self,spotId)
	self:DeploymentController_AVGPointTriggerEvent(spotId);
	local avgInfo = CS.GameData.missionAction.mission.missionInfo.avgInfo;
	if avgInfo ~= nil and avgInfo.pointAvg:ContainsKey(spotId) then
		CS.Data.SetPlayerPrefStrings("PointAVG", spotId);
	end
end
util.hotfix_ex(CS.AVGTrigger,'DeploymentController_AVGPointTriggerEvent',AVGPointTriggerEvent)