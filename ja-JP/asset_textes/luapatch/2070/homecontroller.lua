local util = require 'xlua.util'
xlua.private_accessible(CS.HomeController)

local RefreshProgressBar = function(self,imgBar,num,rate)
	if num >= 1.0 then
		print('fillAmount is full');
		imgBar.fillAmount = 1.0;
	else
		self:RefreshProgressBar(imgBar,num,rate);
	end
end
local _CheckAnnouncementEvents = function(self)
	self:CheckAnnouncementEvents();

	if CS.GameData.listAnnouncementEventInfo.Count > 0 and CS.Data.NeedsAttendance() == true then
		self:OnClickEvent(); 
		self:StartCoroutine(self:CheckPopupEvent());
	end
end
util.hotfix_ex(CS.HomeController,'RefreshProgressBar',RefreshProgressBar)
util.hotfix_ex(CS.HomeController,'CheckAnnouncementEvents',_CheckAnnouncementEvents)