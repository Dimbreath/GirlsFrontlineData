local util = require 'xlua.util'
xlua.private_accessible(CS.SanvisCaptureDynamicEventInfo)
local myUnixToMonthDayString = function(self, intDateTime)
	local date = CS.GameData.UnixToDateTime(intDateTime);
	local month = string.format("%02d", date.Month);
	local day = string.format("%02d", date.Day);
	local hour = string.format("%02d", date.Hour);
	local minute = string.format("%02d", date.Minute);
	local s = string.format("%s/%s %s:%s", month, day, hour, minute);
	return s
end
util.hotfix_ex(CS.SanvisCaptureDynamicEventInfo,'UnixToMonthDayString',myUnixToMonthDayString)