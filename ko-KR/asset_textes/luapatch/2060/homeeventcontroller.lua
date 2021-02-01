local util = require 'xlua.util'
xlua.private_accessible(CS.HomeEventController) 
local _OpenSystemNoticeWindows = function(self) 
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_US then
		CS.AIhelpService.Instance:SetName("Girls'Frontline");
		--self:OpenSystemNoticeWindows(nil); 
	else
		self:OpenSystemNoticeWindows(); 
	end 
end 
util.hotfix_ex(CS.HomeEventController,'OpenSystemNoticeWindows',_OpenSystemNoticeWindows)