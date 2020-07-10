local util = require 'xlua.util'
xlua.private_accessible(CS.HomeEventController)
local TODO = function()

end	
local _OpenSystemNoticeWindows = function(self)	
	self:OpenSystemNoticeWindows(TODO);
end

if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
	if CS.ConfigData.clientVersion == "20501" and CS.ApplicationConfigData.PlatformChannelId == "TX" then
		util.hotfix_ex(CS.HomeEventController,'OpenSystemNoticeWindows',_OpenSystemNoticeWindows)
	end
end

local HomeEventController_Init = function(self,jumpType)
	self:Init(jumpType);
	local special = false;
	for i = 0,CS.GameData.listAttendanceInfo.Count-1 do
		if CS.GameData.listAttendanceInfo[i].type == CS.AttendanceType.special then
			special = true;
		end
	end
	self.listEvent[1].gameObject:SetActive(special);
end

util.hotfix_ex(CS.HomeEventController,'Init',HomeEventController_Init)