local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisCaptureController)
xlua.private_accessible(CS.SangvisChangeMallData)
xlua.private_accessible(CS.RequestExchangeMallList)
xlua.private_accessible(CS.GameData)

local listSangvisTempMall = CS.System.Collections.Generic.List(CS.SangvisChangeMallData)()

local myControlExchangeShop = function(self)
    local currentTime = CS.GameData.GetCurrentTimeStamp()
	for i = listSangvisTempMall.Count - 1, 0, -1 do
		local mallData = listSangvisTempMall[i];
        if (mallData.startTime < currentTime and mallData.endTime > currentTime) then
            CS.GameData.listSangvisExchangeMall:Add(mallData);
			listSangvisTempMall:Remove(mallData);
        end  
    end  
    if (listSangvisTempMall.Count == 0) then
		local changeMallDataList = CS.System.Collections.Generic.List(CS.SangvisChangeMallData)()
		for i = 0 , CS.GameData.listSangvisExchangeMall.Count - 1 do
			if(CS.GameData.listSangvisExchangeMall[i].startTime > currentTime) then
				changeMallDataList:Add(CS.GameData.listSangvisExchangeMall[i]);
			end
		end
        if(changeMallDataList.Count > 0) then
			listSangvisTempMall:AddRange(changeMallDataList);
		end
    end
	self:ControlExchangeShop();
end

local mySuccessHandleData = function(self, www)
	local jsonData = CS.ConnectionController.DecodeAndMapJson(www.text);
	if(jsonData.IsArray) then
		local currentTime = CS.GameData.GetCurrentTimeStamp()
		for i = listSangvisTempMall.Count - 1, 0, -1 do
			local mallData = listSangvisTempMall[i];
			if (mallData.startTime < currentTime and mallData.endTime > currentTime) then
				CS.GameData.listSangvisExchangeMall:Add(mallData);
				listSangvisTempMall:Remove(mallData);
			end  
		end  
		if (listSangvisTempMall.Count == 0) then
			local changeMallDataList = CS.System.Collections.Generic.List(CS.SangvisChangeMallData)()
			for i = 0 , CS.GameData.listSangvisExchangeMall.Count - 1 do
				if(CS.GameData.listSangvisExchangeMall[i].startTime > currentTime) then
					changeMallDataList:Add(CS.GameData.listSangvisExchangeMall[i]);
				end
			end
			if(changeMallDataList.Count > 0) then
				listSangvisTempMall:AddRange(changeMallDataList);
			end
		end
	end
	self:SuccessHandleData(www);
end

util.hotfix_ex(CS.SangvisCaptureController,'ControlExchangeShop',myControlExchangeShop)
util.hotfix_ex(CS.RequestExchangeMallList,'SuccessHandleData',mySuccessHandleData)