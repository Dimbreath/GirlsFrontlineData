local util = require 'xlua.util'
local config = require 'collaboration/Va11/VA11Config'
xlua.private_accessible(CS.DormController)
xlua.private_accessible(CS.DormCafeController)
xlua.private_accessible(CS.DormUIController)
xlua.private_accessible(CS.DormCafeCustomerController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.PLTable)
xlua.private_accessible(CS.CommonController)
xlua.private_accessible(CS.UIManager)
local lastGun
local lastIndex
local initFlag = false
--local Va11Table = {};
--local TableStruct =nil
local fCounter
local specFlag = false
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

LoadCafeCustomers= function(self)
	---------------------------------------------------------------------------------------------------------------------------------------------
	self:LoadCafeCustomers()
	if Va11EventOpen() and tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeLastCounter',"-1")) < 0 then
		
		local pointer = tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeCounter',"-1"))
		if pointer > 0 then
			local customer = self:CreateAndStartCafeCustomer(Va11Table[pointer].gun_code);
			self.listAllAIController:Add(customer);
			CS.DormCafeController.instance:AddCustomer(customer);
		end
	end
end
GetSkinCodeList = function()
	
	UpdateVa11Status(false)
	--容错：如果因为之前没有正确加载，对于EX关未使用情报点解锁且已经关闭最后一段对话的玩家，重新开放最后一段对话 *其他服务器改表的时候更换或者删去这段
	local missionT = CS.GameData.listMission:GetDataById(10285)
	if missionT ~= nil and missionT.clocked == true and CS.GameData.GetItem(8002) == 0 and tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeLastCounter',"-1")) > 0 then
		CS.UnityEngine.PlayerPrefs.SetString('VA11CafeLastCounter',"-1")
	end
	
	local list = CS.DormCafeController.GetSkinCodeList();
	
	if Va11EventOpen() and tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeLastCounter',"-1")) < 0 then
		
		local pointer = tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeCounter',"-1"))
		print("pointer="..tostring(pointer))
		if pointer > 0 then
			--local customer = self:CreateAndStartCafeCustomer(Va11Table[pointer].gun_code);
			--self.listAllAIController:Add(customer);
			--CS.DormCafeController.instance:AddCustomer(customer);
			list:Add(Va11Table[pointer].gun_code);
		end
	end
	return list;
end
PlayGunMemoirAVG  =function(self,id,msg)

	if id == 114514 then
		specFlag = true
		--0613update:开始之后关掉UImanager以免通过退回键跳过调酒AVG。
		print("CS.UIManger.Instance.gameObject:SetActiveF")
		CS.UIManager.Instance.gameObject:SetActive(false)
		fCounter = self:GetEstablishControllerWithType(CS.EstablishType.CafeCounter_405);
		self.txtAVG = CS.ResManager.GetObjectByPath("AVGTxt/VA11/" .. msg, ".txt")
		CS.CommonController.Invoke(function()
			if fCounter ~= nil then
			fCounter.arrPieceController[0]:PlayAnim("action")
			end
		end,1,CS.DormUIController.Instance)
		
		CS.CommonController.Invoke(function()
			CS.DormController.instance:FreezeFrame()
		end, 4.5, CS.DormController.instance)
		
		CS.CommonController.Invoke(function()
			CS.DormController.instance:InstantiateAVG()
			CS.DormUIController.Instance.gameObject:GetComponent("Canvas").enabled = true
		end, 5, CS.DormController.instance)

		CS.CommonController.Invoke(function()
			if fCounter ~= nil then
				fCounter.arrPieceController[0]:StopAnim()
			end
			CS.DormUIController.Instance.interactionController:SetLookAtTarget(nil,CS.UnityEngine.Vector3.zero)
		end,5.5,CS.DormUIController.Instance)
	else
		self:PlayGunMemoirAVG(id,msg)
	end
end
OnAVGEnd = function(self)
	self:OnAVGEnd()
	print("CS.UIManger.Instance.gameObject:SetActiveT")
	CS.UIManager.Instance.gameObject:SetActive(true)
	if Va11EventOpen() and specFlag then
		specFlag = false
		
		--向服务器发送数据
		lastIndex = tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeCounter',"-1"))
		if Va11Table[lastIndex].item_num > 0 then
			local str = "item_change:"..(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeCounter',"-1"))
			local jsonStr = "{\"tips\": \" "..str.."\"}"
			local sb = CS.System.Text.StringBuilder()
			sb:Append(jsonStr)	
			CS.ConnectionController.CreateConnection("Index/tips","",sb,Handler,nil)
		end
		
		UpdateVa11Status(true)
		if(lastGun ~= nil) then
			self.spineHolder:Find(lastGun).gameObject:GetComponent("DormCafeCustomerController"):ShowReadHint()
		end
		-- 刷新红点
		CS.DormUIController.Instance:UpdateRoomSelectDisplay();
	end
	
end
function Handler(www)
	--服务器收到请求，弹窗提示
	if www.text == '1' then
		--最后一个，存到本地防止重复加载对话。
		if lastIndex == #Va11Table then
			CS.UnityEngine.PlayerPrefs.SetString('VA11CafeLastCounter',"1")
		end	
		if Va11Table[lastIndex].item_num > 0 and Va11Table[lastIndex].item_id > 0 then
			CS.GameData.AddItem(Va11Table[lastIndex].item_id,Va11Table[lastIndex].item_num)
			CS.CommonMessageBoxController.Instance:Init(CS.System.String.Format(CS.Data.GetLang(230138),Va11Table[lastIndex].item_num), nil, function()
				CS.CommonController.ConfirmBox(CS.Data.GetLang(230012),function()
					CS.OPSConfig.Instance:GoToScene()
				end)
			end);
		end
		
	end
end
function UpdateVa11Status(readDone)
	local pointer = tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeCounter',"-1"))
	--刚刚进行过对话 直接切换到虚无状态干掉对话气泡
	if readDone then
		lastGun = Va11Table[pointer].gun_code
		CS.UnityEngine.PlayerPrefs.SetString('VA11CafeCounter',"-1")
	else
	--更新状态：	前置关卡已经通过，且未获得情报点->可以进行对话 前置关卡已经通过，且已获得情报点 ->虚无		
		for i=#Va11Table,1,-1 do		
			local mission = CS.GameData.listMission:GetDataById(Va11Table[i].front_mission_id)
			--逆序找到最后一个解锁了的关卡
			
			if mission ~= nil and mission.clocked == false then
				if i ~= #Va11Table then
					CS.UnityEngine.PlayerPrefs.SetString('VA11CafeLastCounter',"-1")
				end
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
					local itemRealNum = CS.GameData.GetItem(Va11Table[i].item_id)
					if itemRealNum <= 0 then
						CS.UnityEngine.PlayerPrefs.SetString('VA11CafeCounter',tostring(i))
					else 
						CS.UnityEngine.PlayerPrefs.SetString('VA11CafeCounter',"-1")	
					end
					
				else			
					CS.UnityEngine.PlayerPrefs.SetString('VA11CafeCounter',"-1")						
				end
				eventPrize = nil;
				break
				
			end
			
		end
	end
	
end
function TempFormat(str,num)
	return (string.gsub(str,"{0}",tostring(num)))
end
util.hotfix_ex(CS.DormCafeController,'GetSkinCodeList',GetSkinCodeList)
util.hotfix_ex(CS.DormController,'PlayGunMemoirAVG',PlayGunMemoirAVG)
util.hotfix_ex(CS.DormController,'OnAVGEnd',OnAVGEnd)