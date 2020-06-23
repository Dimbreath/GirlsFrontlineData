local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterInvestigationUIController)
xlua.private_accessible(CS.TheaterChooseUIController)
local ShowResult = function(self)
	if self.mButtonLastResult.gameObject.activeSelf then
		self:ShowResult();
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
			local curIn = CS.Data.serverTomorrowZero + theaterEventInfo.settle_hour_of_day * 3600 - 24 * 3600; -- curIn下个零点=>往后退settle_hour_of_day个小时=>往前推一天
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
local TheaterChooseUIController_ShowInvestigationViewIfNeed = function(self)
	local theaterEventInfo = CS.TheaterChooseUIController.Instance.mTheaterEventInfo;
	if theaterEventInfo ~= nil then
		local curTime = CS.GameData.GetCurrentTimeStamp(); -- 当前时间点
		local curIn = CS.Data.serverTomorrowZero + theaterEventInfo.settle_hour_of_day * 3600 - 24 * 3600; -- curIn下个零点=>往后退settle_hour_of_day个小时=>往前推一天

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
			CS.TheaterInvestigationUIController.ShowTheaterInvestigationView(CS.TheaterChooseUIController.Instance.mTheaterEventInfo,true);
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
util.hotfix_ex(CS.TheaterInvestigationUIController,'ShowResult',ShowResult)
util.hotfix_ex(CS.TheaterDetailUIController,'SetHelpTextIfNeed',TheaterDetailUIController_SetHelpTextIfNeed)
xlua.hotfix(CS.Data,'IsReinforceTheater',Data_IsReinforceTheater)
xlua.hotfix(CS.TheaterChooseUIController,'ShowInvestigationViewIfNeed',TheaterChooseUIController_ShowInvestigationViewIfNeed)