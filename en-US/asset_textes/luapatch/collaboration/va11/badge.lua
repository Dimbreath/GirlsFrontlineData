local util = require 'xlua.util'
xlua.private_accessible(CS.Badge)

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


local initFlag = false
local Va11Table = {}
local TableStruct =nil
local fCounter
local specFlag = false

UpdateBadge = function(self)
	
	TableStruct = {Id = 1 ,front_mission_id = 10277,followup_mission_id = 10278,avg_txt = 'VA11_1',gun_code ="M870P",item_id = 8002,item_num = 100}
	Va11Table[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 2 ,front_mission_id = 10278,followup_mission_id = 10279,avg_txt = 'VA11_2',gun_code ="K2",item_id = 8002,item_num = 100}
	Va11Table[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 3 ,front_mission_id = 10279,followup_mission_id = 10280,avg_txt = 'VA11_3',gun_code ="OC44",item_id = 8002,item_num = 100}
	Va11Table[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 4 ,front_mission_id = 10280,followup_mission_id = 10281,avg_txt = 'VA11_4',gun_code ="G36",item_id = 8002,item_num = 100}
	Va11Table[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 5 ,front_mission_id = 10281,followup_mission_id = 10282,avg_txt = 'VA11_5',gun_code ="G28",item_id = 8002,item_num = 100}
	Va11Table[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 6 ,front_mission_id = 10282,followup_mission_id = 10283,avg_txt = 'VA11_6',gun_code ="M16A1",item_id = 8002,item_num = 100}
	Va11Table[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 7 ,front_mission_id = 10283,followup_mission_id = 10284,avg_txt = 'VA11_7',gun_code ="M1903",item_id = 8002,item_num = 100}
	Va11Table[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 8 ,front_mission_id = 10284,followup_mission_id = 0,avg_txt = 'VA11_8',gun_code ="FN57",item_id = 8002,item_num = 100}
	Va11Table[TableStruct.Id] = TableStruct

	self:UpdateBadge()
	if not Va11EventOpen() then
		return;
	end
	local va11Badge = self.transform:Find("VA11DormBadge(Clone)");
	if va11Badge ~= nil then
		va11Badge.gameObject:SetActive(false);
	end
	if self.type == CS.Badge.BadgeType.ExistsHomeToDorm or
	(self.gameObject:GetComponent(typeof(CS.EstablishRoomItem)) ~= nil and self.gameObject:GetComponent(typeof(CS.EstablishRoomItem)).roomType == CS.EstablishRoom.Cafe) or
	self.gameObject.name == 'DarkRoom' then
		print(self.type);
		for i=#Va11Table,1,-1 do		
			local mission = CS.GameData.listMission:GetDataById(Va11Table[i].front_mission_id)
			if mission ~= nil and mission.clocked == false then			
				print("mission"..tostring(mission.missionInfo.id).." "..tostring(mission.winCount))
				local eventPrize = nil;
				for m=0,CS.GameData.listMissionEventPrize.Count - 1 do
					eventPrize = CS.GameData.listMissionEventPrize:GetDataByIndex(m);
					if eventPrize.missionId == mission.missionInfo.id then
						break;
					else
						eventPrize = nil;
					end
				end
				--如果通关了关卡
				if (eventPrize ~= nil and mission.UseWinCounter >= eventPrize.bossHpBars) or (eventPrize == nil and mission.UseWinCounter >0) then
					--是否还有情报点？
					local itemRealNum = CS.GameData.GetItem(Va11Table[i].item_id)
					--未获得情报点，这个对话可以进行，显示特殊红点
					if itemRealNum == 0 and tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeLastCounter',"-1")) < 0 then
						print('va11 UpdateBadge true')
						self.isActive = true
						self.GoBadge:SetActive(false)
						if(va11Badge == nil) then
							print('va11 UpdateBadge true nil')
							local Go = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11DormBadge"))					
							if Go ~= nil then
								Go.transform:SetParent(self.transform, false)
								Go.transform:Find("Image_Icon"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,1,1,self.GoBadge:GetComponent(typeof(CS.ExImage)).color.a)
							end
							Go = nil;
						else
							print('va11 UpdateBadge true '..tostring(va11Badge))
							if va11Badge ~= nil then
								va11Badge:Find("Image_Icon"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,1,1,self.GoBadge:GetComponent(typeof(CS.ExImage)).color.a)
								va11Badge.gameObject:SetActive(false);
							end
						end
					end
								
				end
				eventPrize = nil;
				break
			end
		end
	end
	va11Badge = nil;
end


util.hotfix_ex(CS.Badge,'UpdateBadge',UpdateBadge)
