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
