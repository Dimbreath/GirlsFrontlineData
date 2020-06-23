local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionMissionBarController)
local UpdateData = function(self, mission, currentMissionType, MSC, missioninfo)
	if missioninfo == nil and mission ~= nil then
		missioninfo = mission.missionInfo;
	end
	self:UpdateData(mission, currentMissionType, MSC, missioninfo);
end
util.hotfix_ex(CS.MissionSelectionMissionBarController,'UpdateData',UpdateData)