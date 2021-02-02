local util = require 'xlua.util'
xlua.private_accessible(CS.RequestSangvisGashaDraw)
xlua.private_accessible(CS.Package)
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
			end	
			if(prize ~= nil) then
				prize:GetPackage("sangvisPrize")
			end
		end
	end
end
util.hotfix_ex(CS.RequestSangvisGashaDraw,'SuccessHandleData',mySuccessHandleData)