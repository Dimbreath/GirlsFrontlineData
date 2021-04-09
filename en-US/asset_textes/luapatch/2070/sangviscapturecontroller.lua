local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisCaptureController)
xlua.private_accessible(CS.SangvisChangeMallData)
xlua.private_accessible(CS.RequestExchangeMallList)
xlua.private_accessible(CS.GameData)
xlua.private_accessible(CS.SanvisCaptureDynamicEventInfo)

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
local myCaptureSangvisVip = function(self, num)
	self.vipCaptureNum = num
	self.tempVipCapture = num
	if CS.GameData:IsSangvisBedCountEnough() == false and self.currentCaptureGasha.id ~= CS.UserRecord.sangvisGashaId then
		return;
	end
	if(self.currentCaptureGasha.id == CS.UserRecord.sangvisGashaId) then
		self:CaptureSangvisVip(num);
	else
		local times = CS.GameData:GetCurrentTimeStamp();
		local isExist = false;
		for i = 0, CS.GameData.sangvisDynamicEventInfoList.Count-1 do
			local s = CS.GameData.sangvisDynamicEventInfoList[i];
			if s.sangvisGashaIdList:Contains(self.currentCaptureGasha.id) and s.end_time > times and s.start_time < times and s.isAuthor then
				isExist = true;
				break;
			end
		end
		if isExist == true then
			self:CaptureSangvisVip(num);
		else
			 if CS.SangvisGashaponDrawBoxController.Instance ~= nil and CS.SangvisGashaponDrawBoxController.Instance.freeTokenObj.activeSelf then
				CS.CommonController.MessageBox(CS.Data.GetLang(260142), function() 
					CS.CommonController.GotoScene("Home");
				end)
			 else
				self:CaptureSangvisVip(num);
			 end
		end
	end
	
end
util.hotfix_ex(CS.SangvisCaptureController,'CaptureSangvisVip',myCaptureSangvisVip)
util.hotfix_ex(CS.SangvisCaptureController,'ControlExchangeShop',myControlExchangeShop)
util.hotfix_ex(CS.RequestExchangeMallList,'SuccessHandleData',mySuccessHandleData)