local util = require 'xlua.util'
xlua.private_accessible(CS.HomeOperationButton)
local OnClick = function(self)
	if self.statement == CS.HomeOperationState.ShowTheater and CS.GameFunctionSwitch.GetGameFunctionOpen("Theater") then
		if CheckTheaterEvent(self) then		
			CS.CommonController.GotoScene("Theater")
		else
			local stamp = CS.GameData.GetCurrentTimeStamp()
			local theaterEventInfoList = CS.GameData.listTheaterEventInfo
			for i=0,theaterEventInfoList.Count-1 do
				local theaterEventInfo = theaterEventInfoList[i]
				if theaterEventInfo.start_time <= stamp and stamp <= theaterEventInfo.close_time then
					CS.CommonController.MessageBox(CS.Data.GetLang(210162))
				end
			end
		end
	else
		self:OnClick()
	end	
	
end
local CheckTheaterEvent = function(self)
	if self:CheckTheaterEvent() == true then
		local stamp = CS.GameData.GetCurrentTimeStamp()
		local theaterEventInfoList = CS.GameData.listTheaterEventInfo
		for i=0,theaterEventInfoList.Count-1 do
			local theaterEventInfo = theaterEventInfoList[i]
			if theaterEventInfo.start_time <= stamp and stamp <= theaterEventInfo.close_time and theaterEventInfo:isOpenTime(stamp) then
				return true
			end
		end
		return false
	else
		return false
	end
end
util.hotfix_ex(CS.HomeOperationButton,'OnClick',OnClick)
util.hotfix_ex(CS.HomeOperationButton,'CheckTheaterEvent',CheckTheaterEvent)