local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)


local initFlag = false
--local Va11Table = {}
--local TableStruct =nil
local fCounter
local specFlag = false
local ScanFlag = false
local scanObject
local Va11EventOpen = function()
	if CS.OPSConfig.ContainCampaigns:Contains(-32) then
		local stamp = CS.GameData.GetCurrentTimeStamp();
		if stamp >= CS.OPSConfig.startTime and stamp < CS.OPSConfig.endTime then
			return true;
		end
		stamp = nil;
	end
	return false;
end
LoadUI = function(self,campaionid)

	self:LoadUI(campaionid)
	if not Va11EventOpen() then
		return;
	end
	-- 修复联动全通关情报点剩余为0时，每次进活动图仍会提示调酒的bug
	-- 添加判断，若10292已解锁则跳过提示判断
	local missionT = CS.GameData.listMission:GetDataById(10292)
	if missionT == nil or missionT.clocked then
		print('OPSPanelController_LoadUI hasnt clear 10292');
		for i=#Va11Table,1,-1 do		
			local mission = CS.GameData.listMission:GetDataById(Va11Table[i].front_mission_id)		
			if mission ~= nil and mission.clocked == false then		
				local eventPrize = nil;
				for m=0,CS.GameData.listMissionEventPrize.Count - 1 do
					eventPrize = CS.GameData.listMissionEventPrize:GetDataByIndex(m);
					if eventPrize.missionId == mission.missionInfo.id then
						print('OPSPanelController_LoadUI found mission_event_prize '..tostring(eventPrize.missionId));
						break;
					else
						eventPrize = nil;
					end
				end
				--如果通关了关卡
				if (eventPrize ~= nil and mission.UseWinCounter >= eventPrize.bossHpBars) or (eventPrize == nil and mission.UseWinCounter >0) then
					print('OPSPanelController_LoadUI check point item');
					--是否还有情报点？
					local itemRealNum = CS.GameData.GetItem(Va11Table[i].item_id)
					print('OPSPanelController_LoadUI check point item '..tostring(itemRealNum));
					print('OPSPanelController_LoadUI VA11CafeLastCounter '..CS.UnityEngine.PlayerPrefs.GetString('VA11CafeLastCounter',"-1"));
					--未获得情报点，这个对话可以进行，显示特殊红点
					if itemRealNum == 0 and tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeLastCounter',"-1")) < 0 then
						CS.CommonController.ConfirmBox(CS.Data.GetLang(230011),function()
							CS.CommonController.GotoScene("Dorm", 20004)
						end)
					end		
				end
				eventPrize = nil;
				break
			end		
		end
	end
	
	local Va11GameObject = self.leftMain:Find("VA11_Left(Clone)")	
	local Va11ScanBtn = Va11GameObject:Find("Btn_Scanline")
	scanObject = Va11GameObject:Find("VA11_Scanline")
	scanObject.gameObject:SetActive(ScanFlag)
	Va11ScanBtn:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()	
		if ScanFlag then
			scanObject.gameObject:SetActive(false)
			ScanFlag = false
		else
			ScanFlag = true
			if scanObject == nil then
				scanObject = Va11GameObject:Find("VA11_Scanline")
			else
				scanObject.gameObject:SetActive(true)
			end
		end
	end)
	
	
	
end


util.hotfix_ex(CS.OPSPanelController,'LoadUI',LoadUI)
