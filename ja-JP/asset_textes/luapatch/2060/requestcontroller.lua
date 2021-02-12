local util = require 'xlua.util'
xlua.private_accessible(CS.RequestSangvisGashaDraw)
local mySuccessHandleData = function(self, www)
    self:SuccessHandleData(www)
	local jsonData = CS.ConnectionController.DecodeAndMapJson(www.text);
	if(jsonData:Contains("prize_info")) then
		local prizeInfo = jsonData:GetValue("prize_info");
		for i=0, prizeInfo.Count -1 do 	
			local prize
			if(prizeInfo[i]:Contains("real_prize_info") == false) then
				local prizeId = prizeInfo:GetValue(i).Int
				prize = CS.GameData.listPrize:GetDataById(prizeId)
			else
				prize = Package(prizeInfo:GetValue(i):GetValue("real_prize_info"));
			end	
			if(prize ~= nil) then
				--prize:GetPackage("sangvisPrize")
				for  j = 0 , prize.listItemPackage.Count- 1 do
					local item = prize.listItemPackage[i];
					item:GetItems(false);
				end
			end
		end
	end
end
util.hotfix_ex(CS.RequestSangvisGashaDraw,'SuccessHandleData',mySuccessHandleData)