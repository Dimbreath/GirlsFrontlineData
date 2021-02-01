local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisGashaponDrawBoxController)
function Split(szFullString, szSeparator)  
	if string.find(szFullString, szSeparator) == nil then
		return {szFullString}	
	end
	local nFindStartIndex = 1  
	local nSplitIndex = 1  
	local nSplitArray = {}  
	while true do  
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
		if not nFindLastIndex then  
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
			break  
		end  
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
		nSplitIndex = nSplitIndex + 1  
	end  
	return nSplitArray  
end  
local myStart = function(self)
	self:Start();
	local dynamicList = CS.System.Collections.Generic.List(CS.SanvisCaptureDynamicEventInfo)();
	local timeS = CS.GameData.GetCurrentTimeStamp();
	local eventAuthorFreeList = CS.GameData.listEventInfo:FindAll( 
		function(s)
			return s.code == "sangvisAuthorFree" and s.start_time < timeS and s.end_time > timeS
		end);
	for i = 0, eventAuthorFreeList.Count - 1, 1 do
		local authorFree = eventAuthorFreeList[i];
		local condition = authorFree.condition;
		local authorFreeList = Split(condition, ";");
		for j = 1, #authorFreeList, 1 do  -- 拆出来有多少个东西
			local eventInfoD = CS.SanvisCaptureDynamicEventInfo();
			eventInfoD.isAuthor = true;
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
	local authorEventInfo = nil;
	for i = 0, dynamicList.Count - 1, 1 do
		local s = dynamicList[i];
		if(s.sangvisGashaIdList:Contains(self.currentGasha.id) and s.isAuthor == true and s.end_time > CS.GameData.GetCurrentTimeStamp()) then
			authorEventInfo = s;
			break;	
		end
	end
    if (authorEventInfo ~= nil) then
            local authorEventMaxCount = authorEventInfo.maxCount;
			local s = CS.System.String.Format(CS.Data.GetLang(260066), authorEventInfo:StartTime(), authorEventInfo:EndTime(),  authorEventMaxCount);
            self.freeTimeText.text = s;
    end
end
util.hotfix_ex(CS.SangvisGashaponDrawBoxController,'Start',myStart)

