local util = require 'xlua.util'
xlua.private_accessible(CS.GameData)
local myUnixToDayHourMinuteString = function(intDateTime)
	if(intDateTime > 0) then
		local day = 0;
		local hour = 0;
		local minute = 0;
		local second = intDateTime;
		if (second >= 60) then
            minute = math.modf(second / 60);
            second = second % 60;
		end
        if (minute >= 60) then
            hour = math.modf(minute / 60);
            minute = minute % 60;
        end
        if (hour >= 24) then
            day = math.modf(hour / 24);
            hour = hour % 24;
		end
		local days = string.format("%02d", day);
		local hours = string.format("%02d", hour);
		local minutes = string.format("%02d", minute);
		local s = string.format("%sD %sH %sM", days, hours, minutes);
		return s;
	else
		return "00D 00H 00M";
	end
end
util.hotfix_ex(CS.GameData,'UnixToDayHourMinuteString',myUnixToDayHourMinuteString)