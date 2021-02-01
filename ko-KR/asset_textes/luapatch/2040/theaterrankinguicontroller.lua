local util = require 'xlua.util'

xlua.private_accessible(CS.TheaterRankingUIController)
xlua.private_accessible(CS.RankingSPListItem)
local _, LuaDebuggee = pcall(require, 'LuaDebuggee')
if LuaDebuggee and LuaDebuggee.StartDebug then
	LuaDebuggee.StartDebug('127.0.0.1', 9826)
else
	print('Please read the FAQ.pdf')
end

local ClearData = function(item, data)
	if (CS.RankingSPListItem.aplhaSprite == nil) then
		CS.RankingSPListItem.aplhaSprite = item.headImage.sprite;
	end
	if(item.commander ~= nil) then
		CS.UnityEngine.Object.Destroy(item.commander.gameObject)	
		item.commander = nil
	end
	item.rankingData = data
	item.getData = data.getData
	item:Init(data)
	--local initData1_generic = xlua.get_generic_method(CS.RankingSPListItem, 'Init')
	--local initData1 = initData1_generic(CS.TheaterRankingUIController.PlayerRankingData)
	--initData1(item, data);
end
local myRefreshRankData = function(self, dataes, selfData, allDataNum, allItemNum, rankPercent)
	--local initDataO_generic = xlua.get_generic_method(CS.RankingSPListItem, 'InitData')
	--local initDataO = initDataO_generic(CS.TheaterRankingUIController.PlayerRankingData)
	local dataList = dataes;
	for i = 0, dataes.Count-1 do
		if(dataes[i].getData ~= true) then
			if(i+1 > allDataNum) then
				dataList = dataes:FindAll(function (x)
						return x.rank > 0;
					end)
			end	
			break;
		end
	end
	if(dataList.Count > 0) then
		--initDataO(self.first, dataes[0])
		ClearData(self.first, dataList[0])
	else
		self.first:ClearData()
	end
	if(dataList.Count > 1) then
		--initDataO(self.second, dataes[1])
		ClearData(self.second, dataList[1])
	else
		self.second:ClearData()
	end
	if(dataList.Count > 2) then
		--initDataO(self.third, dataes[2])
		ClearData(self.third, dataList[2])
	else
		self.third:ClearData()
	end
	
	local initData_generic = xlua.get_generic_method(CS.CommonListController, 'InitData', 1)
	local initData = initData_generic(CS.TheaterRankingUIController.PlayerRankingData)
	local listItem = self.mRankingListItemHolder:GetComponent(typeof(CS.CommonListController));
	
	if(dataList.Count > 3 and dataList[0].rank < 3) then
		local dataListT = dataList:GetRange(3, dataList.Count - 3);
		initData(listItem, dataListT);
	else 
		if(dataList.Count > 3) then 
			initData(listItem, dataList)
		else
			dataList:RemoveAll(function (s)
					return s ~= nil;
				end)
			initData(listItem, dataList);
		end
	end
	if(allDataNum - 3 > 0) then
		allDataNum = allDataNum - 3
	else 
		allDataNum = 0;
	end
	if(allItemNum - 3 > 0) then
		allItemNum = allItemNum - 3
	else 
		allItemNum = 0;
	end
	self:RefeshSelfData(selfData, allDataNum, allItemNum, rankPercent);
	self.buttom:SetAsLastSibling();
	self.gettingData = false;
end

local myClearData = function(self) 
	if (CS.RankingSPListItem.aplhaSprite == nil) then
        CS.RankingSPListItem.aplhaSprite = self.headImage.sprite;
	end
	if (self.commander ~= nil) then
		CS.UnityEngine.Object.Destroy(self.commander.gameObject);
		self.commander = nil;
	end
	self:ClearData();
end
local myInit = function(self,number,data) 
	if (self.rankData.getData == false or CS.GameData:GetCurrentTimeStamp() > self.rankData.refreshTime) then
	else
		if(number == 1) then
			self:ShowOtherLabel(number, data)
		end
	end
	self:Init(number, data);
end
util.hotfix_ex(CS.TheaterRankingUIController,'RefreshRankData',myRefreshRankData)
util.hotfix_ex(CS.RankingSPListItem,'ClearData',myClearData)
util.hotfix_ex(CS.TheaterRankingLabelUIController,'Init',myInit)