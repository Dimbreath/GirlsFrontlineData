local util = require 'xlua.util'
xlua.private_accessible(CS.HomeOperationButton)
local ChangeButtonImage = function(self)
	if self.statement == CS.HomeOperationState.ResumeBattle then
		if self.info.campaign < 0 then
			local flag = false
			for i = 0,CS.MissionSelectionActivityController.MissionConfigs.Count-1 do
				if CS.MissionSelectionActivityController.MissionConfigs[i].campaignId == self.info.campaign then
					flag = true
					break
				end		
			end
			if flag == false then
				self.imageBackMission.sprite = CS.CommonController.LoadPngCreateSprite("Pics/Icons/OPS/" .. CS.OPSConfig.Instance.MissionSelectionTex .. "_base")
				return
			end
		end
	end
	self:ChangeButtonImage()
end
local OnClick = function(self)

	self:OnClick()
	if self.statement == CS.HomeOperationState.ShowTheater then
		if CheckTheaterEvent(self) then		
			CS.CommonController.GotoScene("Theater")
		else
			local stamp = CS.GameData.GetCurrentTimeStamp()
			local theaterEventInfoList = CS.GameData.listTheaterEventInfo
			for i=0,theaterEventInfoList.Count-1 do
				local theaterEventInfo = theaterEventInfoList:GetDataByIndex(i)
				if theaterEventInfo.start_time <= stamp and stamp <= theaterEventInfo.close_time then
					CS.CommonController.MessageBox(CS.Data.GetLang(210162))
				end
			end
		end
	end
end
local CheckTheaterEvent = function(self)
	if self:CheckTheaterEvent() == true then
		local stamp = CS.GameData.GetCurrentTimeStamp()
		local theaterEventInfoList = CS.GameData.listTheaterEventInfo
		for i=0,theaterEventInfoList.Count-1 do
			local theaterEventInfo = theaterEventInfoList:GetDataByIndex(i)
			if theaterEventInfo.start_time <= stamp and stamp <= theaterEventInfo.close_time and theaterEventInfo:isOpenTime(stamp) then
				return true
			end
		end
		return false
	else
		return false
	end
end
function CheckOpenTime()
	
end
util.hotfix_ex(CS.HomeOperationButton,'ChangeButtonImage',ChangeButtonImage)
util.hotfix_ex(CS.HomeOperationButton,'OnClick',OnClick)
util.hotfix_ex(CS.HomeOperationButton,'CheckTheaterEvent',CheckTheaterEvent)