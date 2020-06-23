local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisCaptureController)
local myResetGashaData = function(self)
    self:ResetGashaData()
	local count = self.gashaTabList.Count;
	for i = count - 1, 0 , -1 do
		local sangvisTab = self.gashaTabList[i];
		local gasha = CS.GameData.listSangvisCaptureGasha:GetDataById(sangvisTab.gashaId);
		if gasha.startTime > CS.GameData:GetCurrentTimeStamp() then
			self.gashaTabList[i].gameObject:SetActive(false);
			self.gashaTabList:RemoveAt(i);
		end
	end
end
local myCaptureSangvisVip = function(self, num)
	if not CS.GameData:IsSangvisBedCountEnough() then
		-- 如果床位已满就不往下走了，避免基建弹窗重叠
		return;
	end
	if self.currentCaptureGasha.id ~= CS.UserRecord.sangvisGashaId then
		-- 开始判断 由于之前已经把事件池中的清掉了 所以这里判断下是否有过期的 就是隔夜请求了
		local tag = false;
		for i = 0, CS.GameData.sangvisDynamicEventInfoList.Count - 1, 1 do
			local s = CS.GameData.sangvisDynamicEventInfoList[i];
			if(s.sangvisGashaIdList:Contains(self.currentCaptureGasha.id) and s.end_time < CS.GameData.GetCurrentTimeStamp() and s.isAuthor) then
				tag = true;
			end
		end
		if(tag) then
		--  这里是 隔夜 所以直接弹窗提酒可以了
			CS.CommonController.MessageBox(CS.Data.GetLang(70024), function() CS.CommonController.GotoScene("Home"); end);
		else
			self:CaptureSangvisVip(num);
		end
	else
		self:CaptureSangvisVip(num);
	end
end
local myRequestSangvisGashaDraw = function(self, request)
	if(request.drawType == 2) then
		if(request.resultSangvisGunList.Count > 0 or request.resultPackageList.Count > 0) then
			self:RequestSangvisGashaDraw(request);
		end
	else
		self:RequestSangvisGashaDraw(request);
	end
	
end
local myShowFreeTrialDesc = function(self)
	CS.SangvisGashaCharacterStateController.Close();
	local dynamicList = CS.System.Collections.Generic.List(CS.SanvisCaptureDynamicEventInfo)();
	local timeS = CS.GameData.GetCurrentTimeStamp();
	local eventAuthorFreeList = CS.GameData.listEventInfo:FindAll( 
		function(s)
			return s.code == "sangvisDailyFree" and s.start_time < timeS and s.end_time > timeS
		end);
	for i = 0, eventAuthorFreeList.Count - 1, 1 do
		local authorFree = eventAuthorFreeList[i];
		local condition = authorFree.condition;
		local authorFreeList = Split(condition, ";");
		for j = 1, #authorFreeList, 1 do  -- 拆出来有多少个东西
			local eventInfoD = CS.SanvisCaptureDynamicEventInfo();
			eventInfoD.isAuthor = false;
			local array = Split(authorFreeList[j], ':'); -- 拆出来 前面是数量 后面的对应的卡池
			eventInfoD.maxCount = tonumber(array[1]); -- 对应的是最大数量
			local poolList = Split(array[2], ','); -- 对应的是有哪些池子
			for k = 1, #poolList, 1 do
				eventInfoD.sangvisGashaIdList:Add(tonumber(poolList[k]));
			end
			eventInfoD.start_time = authorFree.start_time;
            eventInfoD.end_time = authorFree.end_time;
            dynamicList:Add(eventInfoD);
		end
	end
	local freeEventInfo = nil;
	for i = 0, dynamicList.Count - 1, 1 do
		local s = dynamicList[i];
		if(s.sangvisGashaIdList:Contains(self.currentCaptureGasha.id) and s.isAuthor == false and s.end_time > CS.GameData.GetCurrentTimeStamp()) then
			freeEventInfo = s;
			break;	
		end
	end
    if (freeEventInfo ~= nil) then
            local freeEventMaxCount = freeEventInfo.maxCount;
            local desc = CS.System.String.Format(CS.Data.GetLang(260098), freeEventInfo:StartTime(), freeEventInfo:EndTime(), freeEventMaxCount);
            CS.CommonMessageBoxController.Instance:Show(desc);
    end
end
util.hotfix_ex(CS.SangvisCaptureController,'ResetGashaData',myResetGashaData)
util.hotfix_ex(CS.SangvisCaptureController,'CaptureSangvisVip',myCaptureSangvisVip)
util.hotfix_ex(CS.SangvisCaptureController,'RequestSangvisGashaDraw',myRequestSangvisGashaDraw)
util.hotfix_ex(CS.SangvisCaptureController,'ShowFreeTrialDesc',myShowFreeTrialDesc)