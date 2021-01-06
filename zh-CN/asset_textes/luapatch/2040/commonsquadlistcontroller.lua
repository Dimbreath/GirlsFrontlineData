local util = require 'xlua.util'
xlua.private_accessible(CS.CommonSquadListController)
xlua.private_accessible(CS.SquadTranscribeListController)
xlua.private_accessible(CS.IllustratedBookSquadListController)

local CreateList = function(self)
	local cacheSquadList = CS.GameData.listSquadInfo;
	CS.GameData.listSquadInfo = CS.tBaseDatas(CS.SquadInfo)();
	for i=0,cacheSquadList.Count - 1 do
		local info = cacheSquadList:GetDataByIndex(i);
		if info.id < 1000 and info.type < 4 then
			CS.GameData.listSquadInfo:Add(info);
		end
	end
	self:CreateList();
	CS.GameData.listSquadInfo = cacheSquadList;
	cacheSquadList = nil;
end
util.hotfix_ex(CS.CommonSquadListController,'CreateList',CreateList)

local UpdateListSquadInfo = function(self)
	local cacheSquadList = CS.GameData.listSquadInfo;
	CS.GameData.listSquadInfo = CS.tBaseDatas(CS.SquadInfo)();
	for i=0,cacheSquadList.Count - 1 do
		local info = cacheSquadList:GetDataByIndex(i);
		if info.id < 1000 and info.type < 4 then
			CS.GameData.listSquadInfo:Add(info);
		end
	end
	self:UpdateListSquadInfo();
	CS.GameData.listSquadInfo = cacheSquadList;
	cacheSquadList = nil;
end
util.hotfix_ex(CS.SquadDataAnalysisController,'UpdateListSquadInfo',UpdateListSquadInfo)

local InitUIElements = function(self)
	local cacheSquadList = CS.GameData.listSquadInfo;
	CS.GameData.listSquadInfo = CS.tBaseDatas(CS.SquadInfo)();
	for i=0,cacheSquadList.Count - 1 do
		local info = cacheSquadList:GetDataByIndex(i);
		if info.id < 1000 and info.type < 4 then
			CS.GameData.listSquadInfo:Add(info);
		end
	end
	self:InitUIElements();
	CS.GameData.listSquadInfo = cacheSquadList;
	cacheSquadList = nil;
end
util.hotfix_ex(CS.IllustratedBookSquadListController,'InitUIElements',InitUIElements)

local InitUI = function(self)
	local cacheSquadList = CS.GameData.listSquadInfo;
	CS.GameData.listSquadInfo = CS.tBaseDatas(CS.SquadInfo)();
	for i=0,cacheSquadList.Count - 1 do
		local info = cacheSquadList:GetDataByIndex(i);
		if info.id < 1000 and info.type < 4 then
			CS.GameData.listSquadInfo:Add(info);
		end
	end
	self:InitUI();
	CS.GameData.listSquadInfo = cacheSquadList;
	cacheSquadList = nil;
end
util.hotfix_ex(CS.SquadTranscribeListController,'InitUI',InitUI)