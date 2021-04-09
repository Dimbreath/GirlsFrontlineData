local util = require 'xlua.util'
xlua.private_accessible(CS.IllustratedBookCGPlayBackController)
local InitUIElements = function(self)
	for i=0,CS.GameData.listAVGPlayBack.Count-1 do
		local info = CS.GameData.listAVGPlayBack:GetDataByIndex(i);
		if CS.System.String.IsNullOrEmpty(info.scripts) then
			--print(info.id);
			if info.campaign>0 then
				info.campaign = 99999;
			else
				info.campaign = -99999;
			end
		end
	end	
	self:InitUIElements();
end

util.hotfix_ex(CS.IllustratedBookCGPlayBackController,'InitUIElements',InitUIElements)

