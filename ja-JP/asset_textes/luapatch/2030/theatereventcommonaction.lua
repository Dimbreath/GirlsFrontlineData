-- 这个脚本修复2030的战区bug
local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterEventCommonAction)
xlua.private_accessible(CS.TheaterBattleTeamSelectionUIController)
xlua.private_accessible(CS.TheaterCombatSettlementUIController)
xlua.private_accessible(CS.TheaterEventUIController)
xlua.private_accessible(CS.TheaterAreaDetailUIController)
xlua.private_accessible(CS.TheaterInvestigationUIController)
xlua.private_accessible(CS.TheaterChooseUIController)
local SortComparison = function(left, right)
	if left.battle_percent == right.battle_percent then
		return left.GetTheaterInfo.rank - right.GetTheaterInfo.rank;
	else
		if left.battle_percent - right.battle_percent > 0 then
			return 1;
		else
			return -1;
		end
	end

end
local GetSlowestTheaterInfo = function(self)
	print("GetSlowestTheaterInfo")
	local mSortedTheaterAction = {};
	local iter = self.mDicTheaterAction:GetEnumerator();
	while iter:MoveNext() do
		if iter.Current.Value ~= nil and not iter.Current.Value.isCoreTheater then
			table.insert(mSortedTheaterAction, iter.Current.Value);
		end
	end
	iter = nil;
	table.sort(mSortedTheaterAction, function(left,right)
		if left.battle_percent == right.battle_percent then
			return left.GetTheaterInfo.rank < right.GetTheaterInfo.rank;
		else
			return left.battle_percent < right.battle_percent;
		end
	end)
	return mSortedTheaterAction[1].GetTheaterInfo;
end
local GetCurrentBattleScore = function(self,info)
	local sum = 0;
	local isComplete = CS.Data.isTheaterAreaComplete(info);
	local action = CS.GameData.mTheaterExerciseAction;
	for i=0,action.battle_enemy_no do
		if isComplete then
			sum = sum + info:GetOccupiedEnemyScore(i);
		else
			sum = sum + info:GetEnemyScore(i);
		end
	end
	isComplete = nil;
	action = nil;
	return sum;
end
local ShowNormalScoreNode = function(self,result)
	self.mTextEnemyCount.text = CS.System.String.Format('<color=#ffffffff>{0}</color>/{1}',math.min(result.battle_count,10),10);
	local areaIsComplete = CS.Data.isTheaterAreaComplete(result.mTheaterAreaInfo);
	local sum = 0;
	local action = result.lastTheaterExerciseAction;
	local battleCountWithoutBoss = math.min(action.battle_enemy_no,9);
	for i=0,battleCountWithoutBoss do
		if areaIsComplete then
			sum = sum + result.mTheaterAreaInfo:GetOccupiedEnemyScore(i);
		else
			sum = sum + result.mTheaterAreaInfo:GetEnemyScore(i);
		end
	end
	self.mTextEnemyScore.text = tostring(sum);
	areaIsComplete = nil;
	sum = nil;
	action = nil;
	battleCountWithoutBoss = nil;
end
local ShowTheaterInvestigationView = function(self,info)
	if info ~= nil then
		self:ShowTheaterInvestigationView(info);
	else
		if self.mCurrentIncidentInfoList ~= nil and self.mCurrentIncidentInfoList.Count > 0 then
			self:ShowTheaterInvestigationView(self.mCurrentIncidentInfoList[0]);
			if CS.TheaterInvestigationUIController.Instance.gameObject.activeSelf then
				CS.TheaterInvestigationUIController.Instance:ShowResult();
			end 
		end
	end
end
local GetAllEnemyScore = function(self,info,isComplete)
	local sum = self:GetAllEnemyScore(info,isComplete);
	local theaterInfo = CS.GameData.listTheaterInfo:GetDataById(info.theater_id);
	if theaterInfo.reinforce_coef > 0 and not CS.Data.IsReinforceTheater(theaterInfo) then
		sum = math.floor(sum / (theaterInfo.reinforce_coef / 100));
	end
	theaterInfo = nil;
	return sum;
end
local TheaterAreaDetailUIController_Init = function(self,index,info)
	if self.lastInfo ~= info then
		self:Init(index,info);
		local theaterInfo = CS.GameData.listTheaterInfo:GetDataById(info.theater_id);
		if theaterInfo.rank == 4 then
			self.mTextRankName.text = CS.Data.GetLang(210058);
		end
		theaterInfo = nil;
	end
end
local Data_IsReinforceTheater = function(info)
	local result = false;
	if CS.GameData.theaterEventCommonAction:GetSlowestTheaterInfo() == info then
		if not CS.GameData.theaterEventSelfAction.mDicTheaterAction:ContainsKey(info.id) then
			result = true;
		else
			local theaterEventInfo = CS.GameData.listTheaterEventInfo:GetDataById(info.theater_event_id);
			local action = CS.GameData.theaterEventSelfAction.mDicTheaterAction[info.id];
			local last = action.last_exercise_finish_time; -- 最后一次的完成时间
			local cur = CS.GameData.GetCurrentTimeStamp(); -- 当前时间点
			local curIn = CS.GameData.serverTomorrowZero + theaterEventInfo.settle_hour_of_day * 3600 - 24 * 3600; -- curIn下个零点=>往后退settle_hour_of_day个小时=>往前推一天
			if curIn > cur then -- 如果curIn在cur之后（即当前时间在凌晨4点前），则将curIn再往前推一天
				curIn = curIn - 24 * 3600;
			end
			if curIn >= last then -- curIn在last之后，则有支援效果
				result = true;
			end
			theaterEventInfo = nil;
			action = nil;
			last = nil;
			cur = nil;
			curIn = nil;
		end
	end
	return result;
end
local TheaterDetailUIController_SetHelpTextIfNeed = function(self,info)
	if Data_IsReinforceTheater(info) then
		self.mTextIncrease.text = CS.System.String.Format(CS.Data.GetLang(210060), info.reinforce_coef-100);
		self.mGameObjectIncrease.gameObject:SetActive(true);
	else
		self.mGameObjectIncrease.gameObject:SetActive(false);
	end
end
local TheaterChooseUIController_ShowInvestigationViewOneTime = function(self)
	local theaterEventInfo = CS.TheaterChooseUIController.Instance.mTheaterEventInfo;
	if theaterEventInfo ~= nil then
		local curTime = CS.GameData.GetCurrentTimeStamp(); -- 当前时间点
		local curIn = CS.GameData.serverTomorrowZero + theaterEventInfo.settle_hour_of_day * 3600 - 24 * 3600; -- curIn下个零点=>往后退settle_hour_of_day个小时=>往前推一天

		local value; 
		if curIn > curTime then --没到4点，昨天
			value = tostring(curIn - 24 * 3600);
		end
		if curTime >= curIn then --过了4点，今天
			value = tostring(curIn);
		end
		local key = 'TheaterInvestigation'..tostring(CS.TheaterChooseUIController.Instance.mTheaterEventInfo.id)..'UnlockPerform';
		local saveValue= CS.Data.GetPlayerPrefString(tostring(CS.GameData.userInfo.userId),key);
		if saveValue ~= value then
			CS.TheaterEventUIController.Instance:ShowTheaterInvestigationView();
			CS.Data.SetPlayerPrefString(tostring(CS.GameData.userInfo.userId),key,value);
		end
		theaterEventInfo=nil;
		curTime = nil;
		curIn = nil;
		value = nil;
		key = nil;
		saveValue = nil;
	end
end
xlua.hotfix(CS.TheaterEventCommonAction,'GetSlowestTheaterInfo',GetSlowestTheaterInfo)
xlua.hotfix(CS.TheaterBattleTeamSelectionUIController,'GetCurrentBattleScore',GetCurrentBattleScore)
xlua.hotfix(CS.TheaterCombatSettlementUIController,'ShowNormalScoreNode',ShowNormalScoreNode)
util.hotfix_ex(CS.TheaterEventUIController,'ShowTheaterInvestigationView',ShowTheaterInvestigationView)
util.hotfix_ex(CS.TheaterAreaDetailUIController,'GetAllEnemyScore',GetAllEnemyScore)
util.hotfix_ex(CS.TheaterAreaDetailUIController,'Init',TheaterAreaDetailUIController_Init)
util.hotfix_ex(CS.TheaterDetailUIController,'SetHelpTextIfNeed',TheaterDetailUIController_SetHelpTextIfNeed)
xlua.hotfix(CS.Data,'IsReinforceTheater',Data_IsReinforceTheater)
xlua.hotfix(CS.TheaterChooseUIController,'ShowInvestigationViewOneTime',TheaterChooseUIController_ShowInvestigationViewOneTime)