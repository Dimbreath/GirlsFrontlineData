local util = require 'xlua.util'
xlua.private_accessible(CS.HomeEventBarController)
local strTimeRemain;
local mytextTimeRemain;

local ShowTimeRemain = function()
	mytextTimeRemain.text = strTimeRemain;
end

local OnEndDragXHandle = function(self,time)
	time = 0.5;
	self:OnEndDragXHandle(time);
	local span = self.listEventBanner[self.currentIndex].endTimeStamp - CS.GameData.GetCurrentTimeStamp();
    local totalHour = span / 3600;
	local d = totalHour / 24
	if d<0 then
		d = 0;
	end
	if d>99 then
		d = 99;
	end
	day = math.floor( d );
	if day == 99 then
		hour = 99;
	else
		hour = totalHour % 24
	end
	showDay = math.floor( day );
	showHour = math.floor( hour )
	strTimeRemain = CS.Data.GetLang(1119) .. showDay .. CS.Data.GetLang(1122) .. showHour .. CS.Data.GetLang(1121);
	mytextTimeRemain = self.textTimeRemain;
	CS.CommonController.Invoke(ShowTimeRemain, 0.2, self);
end
util.hotfix_ex(CS.HomeEventBarController,'OnEndDragXHandle',OnEndDragXHandle)