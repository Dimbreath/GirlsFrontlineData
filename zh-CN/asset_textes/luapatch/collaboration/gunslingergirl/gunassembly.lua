local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.GF.Battle.BattleController)
xlua.private_accessible(CS.BattleFieldTeamHolder)
local GunPartsData = {}
local GunAssemblyData = {}

local CurrentGunPartsID = {} --玩家进入此战时 收集了哪些零件？
local CurrentGunPartsObject = {}

local CurrentAssemblyID --正在拼哪个枪
local CurrentAssemblyCount --拼枪顺序
local AssemblyGunPartsIDList = {}--拼上去的部件顺序
local lastGunPartsID --上个拼上去的部件ID
local GunAssemblyCount --已经拼了几把枪
local GunAssemblyAbleCount --最多可以拼几把枪

local countdown = nil --倒计时
local countdownTimer = 0

local gunWeight

local btnBack = nil
local btnUndo = nil
local btnReset = nil

local inited = false
--Awake：初始化数据
Awake = function()
	
	InitGunAssemblyData()	
	InitGunPartsData()
	TestMissionBuffPart()
	
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
end
function InitGunAssemblyData()	
	local TableStruct = {ID = 1, Name = "P90", GirlName = "ASSEMBLATO DA HENRIETTA",member = "1001,1002,1003,1004", time = 60}	
	GunAssemblyData[TableStruct.ID] = TableStruct	
	
end
function InitGunPartsData()	
	local TableStruct = {ID = 1001, buff_id = 987001, group_id = 1, weight = 1, limit = 5, isLimitUnder = true}	
	GunPartsData[1] = TableStruct
	
	TableStruct = {ID = 1002, buff_id = 987002, group_id = 1, weight = 1, limit = 0, isLimitUnder = false}	
	GunPartsData[2] = TableStruct
	
	TableStruct = {ID = 1003, buff_id = 987003, group_id = 1, weight = 1, limit = 1, isLimitUnder = false}	
	GunPartsData[3] = TableStruct
	
	TableStruct = {ID = 1004, buff_id = 987004, group_id = 1, weight = 1, limit = 2, isLimitUnder = false}	
	GunPartsData[4] = TableStruct
end
function TestMissionBuffPart()
	local cnt = 1
	for j=1,#GunPartsData do
		CurrentGunPartsID[cnt] = GunPartsData[j].ID
		cnt = cnt + 1		
	end
end
function CheckMissionBuffPart()
	local cnt = 1
	local listBuffAction = CS.GF.Battle.BattleController.Instance.currentSpotAction.listFriendBuffAction
	for i=0,listBuffAction.Count -1 do
		local missionBuffId = listBuffAction[i].missionBuffCfgId
		for j=1,#GunPartsData do
			if missionBuffId == GunPartsData[j].buff_id then
				CurrentGunPartsID[cnt] = GunPartsData[j].ID
				cnt = cnt + 1
			end
		end
	end
end
--Start: 加载组件
Start = function()
	print("GunAssemblyStart")

	btnBack = BtnBack:GetComponent(typeof(CS.ExButton))
	btnUndo = BtnUndo:GetComponent(typeof(CS.ExButton))
	btnReset = BtnReset:GetComponent(typeof(CS.ExButton))

	--添加监听事件
	btnBack.onClick:AddListener(
		function()
			OnClickAssemblyEnd()
		end)
	btnUndo.onClick:AddListener(
		function()
			ReturnLastGunParts()
		end)
	btnReset.onClick:AddListener(
		function()
			ResetAssembly()
		end)
	
	--根据已经收集的零件判断玩家现在可以拼几把枪 并初始化倒计时
	CalcGunAssemblyCount()
	--初始化零件显示
	ShowGunParts()
	ResetAssembly()
	self.transform:SetParent(CS.BattleUIController.Instance.transform:Find('UI'),false)
	CS.GF.Battle.BattleController.Instance.isPause = true
	CS.BattleUIPauseController.Instance:UpdateState()
	inited = true
end
--Update: 计算倒计时
Update = function()
	if inited then
		countdownTimer = countdownTimer + CS.UnityEngine.Time.unscaledDeltaTime
		TextCountdown:GetComponent(typeof(CS.ExText)).text = tostring(countdown - countdownTimer)
		if countdownTimer > countdown then
			EndAssembly()
		end
	end
end
 

function OnClickAssemblyEnd()
	--弹出提示
	if GunAssemblyCount == 0 then
		CS.CommonController.ConfirmBox("放弃拼装",function()
			EndAssembly()
		end,nil,CS.ConfirmType.Normal,0,true)
	else
		CS.CommonController.ConfirmBox("提前结束",function()
				EndAssembly()
			end)
	end
end
--结束拼枪：倒计时结束 或玩家点击后退按钮 或玩家拼完了所有可以拼的枪
function EndAssembly()
	CS.GF.Battle.BattleController.Instance.isPause = false
	CS.BattleUIPauseController.Instance:UpdateState()
	if GunAssemblyCount == 0 then
		CS.GF.Battle.BattleController.Instance:TriggerBattleFinishEvent(true)
	else
		for i=0,CS.GF.Battle.BattleController.Instance.enemyTeamHolder.listCharacter.Count-1 do
			local DamageInfo = CS.GF.Battle.BattleDamageInfo()
			CS.GF.Battle.BattleController.Instance.enemyTeamHolder.listCharacter[i]:UpdateLife(DamageInfo, -999999)
		end
	end
	CS.UnityEngine.Object.Destroy(self.gameObject)
end
--初始化/重置数据 注意不重新计算倒计时 也不重置已经拼好的...
function ResetAssembly()
	lastGunPartsID = 0
	gunWeight = 0
	CurrentAssemblyID = -1
	for i=1,#CurrentGunPartsID do
		GunPartShowStep(CurrentGunPartsObject[i],0)
	end
	AssemblyGunPartsIDList = {}

end
--便捷函数，循环摧毁物体
function DestroyChildren(transform)
	for i=0,transform.childCount-1 do
		CS.UnityEngine.Object.Destroy(transform:GetChild(i).gameObject)
	end
	return 
end
function GetGunPartsDataById(id)
	for i=1,#GunPartsData do
		if GunPartsData[i].ID == id then
			return GunPartsData[i]
		end
	end
	return nil
end
function GetGunAssemblyDataById(id)
	for i=1,#GunAssemblyData do
		if GunAssemblyData[i].ID == id then
			return GunAssemblyData[i]
		end
	end
	return nil
end
function OnClickGunParts(id)
	print("OnClickGunParts "..id)
	local data = GetGunPartsDataById(id)
	if data == nil then
		return
	end
	if id == lastGunPartsID then
		ReturnLastGunParts()
	else
		if (data.isLimitUnder and data.limit > gunWeight) or (not data.isLimitUnder and data.limit < gunWeight) then
			AddGunParts(id)
		else
			--弹出提示
			print("不满足拼装要求")
		end
	end
	
end
function AddGunParts(id)
	print("AddGunParts "..id)
	local data = GetGunPartsDataById(id)
	if CurrentAssemblyID == -1 then
		CurrentAssemblyID = data.group_id
		local AssemblyData = GetGunAssemblyDataById(CurrentAssemblyID)
		TextGunName:GetComponent(typeof(CS.ExText)).text = tostring(AssemblyData.Name)
		TextGunslingerName:GetComponent(typeof(CS.ExText)).text = tostring(AssemblyData.GirlName)
		
	else 
		if not CurrentAssemblyID == data.group_id then
			return
		end
	end
	for i=1,#AssemblyGunPartsIDList do
		if AssemblyGunPartsIDList[i] == id then
			return
		end
	end
	AssemblyGunPartsIDList[#AssemblyGunPartsIDList + 1] = id
	lastGunPartsID =AssemblyGunPartsIDList[#AssemblyGunPartsIDList]
	for i=1,#CurrentGunPartsID do
		if CurrentGunPartsID[i] == id then
			gunWeight = gunWeight + GetGunPartsDataById(id).weight
			print(#CurrentGunPartsObject)
			GunPartShowStep(CurrentGunPartsObject[i],#AssemblyGunPartsIDList)
		end
	end
	CheckAssemblyGunComplete()
end
function CheckAssemblyGunComplete()
	local data = GetGunAssemblyDataById(CurrentAssemblyID)
	local assemblyMemberArray = Split(data.member,',')
	for i=1, #assemblyMemberArray do
		local id = tonumber(assemblyMemberArray[i])
		print (id)
		local flag = false
		for i=1,#AssemblyGunPartsIDList do
			if AssemblyGunPartsIDList[i] == id then
				flag = true
				break
			end
		end
		if not flag then
			return
		end
	end
	
	for i=1,#CurrentGunPartsObject do
		CS.UnityEngine.Object.Destroy(CurrentGunPartsObject[i])
	end
	GunAssemblyCount = GunAssemblyCount +1
	if GunAssemblyCount >= GunAssemblyAbleCount then
		EndAssembly()
	end
end
function ReturnLastGunParts()	
	for i=1,#CurrentGunPartsID do
		if CurrentGunPartsID[i] == lastGunPartsID then
			GunPartShowStep(CurrentGunPartsObject[i],0)
			break
		end
	end
	gunWeight = gunWeight - GetGunPartsDataById(lastGunPartsID).weight
	table.remove(AssemblyGunPartsIDList)

	if #AssemblyGunPartsIDList == 0 then
		ResetAssembly()
	else
		lastGunPartsID =AssemblyGunPartsIDList[#AssemblyGunPartsIDList]
	end

end

function CalcGunAssemblyCount()
	GunAssemblyCount = 0
	GunAssemblyAbleCount = 0
	countdown = 60
	for i=1,#GunAssemblyData do
		local assemblyMemberArray = Split(GunAssemblyData[i].member,',')
		local assemblyMemberFlag = true
		for j=1, #assemblyMemberArray do
			local id = tonumber(assemblyMemberArray[j])
			local GunPartFlag = false
			for k=1,#CurrentGunPartsID do
				if CurrentGunPartsID[k] == id then
					GunPartFlag = true
					break
				end
			end
			if not GunPartFlag then
				assemblyMemberFlag = false
				break
			end
		end
		if assemblyMemberFlag then
			GunAssemblyAbleCount = GunAssemblyAbleCount + 1
			if countdown > GunAssemblyData[i].time then
				countdown = GunAssemblyData[i].time
			end
		end
	end
end
function ShowGunParts()
	for i=1,#CurrentGunPartsID do
		local subpart = CS.UnityEngine.Object.Instantiate(GOGunPart)
		subpart.gameObject.transform:SetParent(GOGunPartHolder.transform,false)
		subpart.gameObject:SetActive(true)
		subpart:GetComponent(typeof(CS.ExButton)).onClick:AddListener(
		function()
			OnClickGunParts(CurrentGunPartsID[i])
		end)
		CurrentGunPartsObject[#CurrentGunPartsObject+1] = subpart
		GunPartShowStep(subpart,0)
	end
end
function GunPartShowStep(gunpart,step)
	if step == 0 then
		gunpart.transform:Find("Tex_Step").gameObject:SetActive(false)
		gunpart.transform:Find("Img_StepBG").gameObject:SetActive(false)
		gunpart.transform:Find("UI_Text").gameObject:SetActive(false)
	else
		gunpart.transform:Find("Tex_Step").gameObject:SetActive(true)
		gunpart.transform:Find("Img_StepBG").gameObject:SetActive(true)
		gunpart.transform:Find("UI_Text").gameObject:SetActive(true)
		gunpart.transform:Find("Tex_Step").gameObject:GetComponent(typeof(CS.ExText)).text = tostring(step)
	end

end


function Split(szFullString, szSeparator)
	if(szFullString == nil) then
		return nil
	end
	local nFindStartIndex = 0
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

function GenColor(r,g,b,a)
	if(r<=1 and g<=1 and b<=1 and a<=1) then	
		return CS.UnityEngine.Color(r,g,b,a)
	else
		return CS.UnityEngine.Color(r/255,g/255,b/255,a/255)
	end
end

function PlaySFX(FXname)

	if FXname == "invaild_press" then
		CS.CommonAudioController.PlayUI("UI_va_buttonnoclick")
	end
	if FXname == "vaild_press" then
		CS.CommonAudioController.PlayUI("UI_va_jukepick")
	end
	if FXname == "select_type" then
		CS.CommonAudioController.PlayUI("UI_va_jukepick")
	end
	if FXname == "vaild_select" then
		CS.CommonAudioController.PlayUI("UI_va_jukepick")
	end
	if FXname == "invaild_select" then
		CS.CommonAudioController.PlayUI("UI_va_buttonnoclick")
	end
	if FXname == "ice" then
		CS.CommonAudioController.PlayUI("UI_va_iceadd")
	end
	if FXname == "age" then
		CS.CommonAudioController.PlayUI("UI_va_ageadd")
	end
	if FXname == "pour" then
		CS.CommonAudioController.PlayUI("UI_va_addingredient")
	end
	if FXname == "reset" then
		CS.CommonAudioController.PlayUI("UI_va_buttonclick")
	end
	if FXname == "match" then
		CS.CommonAudioController.PlayUI("UI_va_glassserve")
	end
	if FXname == "flair" then
		CS.CommonAudioController.PlayUI("UI_va_mixdone")
	end
end
function PlayBottleEffect(num)
	BottleEff:SetActive(false)
	BottleEff:GetComponent("ExImage").color = AlcoholColorProgress[num]
	BottleEff:SetActive(true)
end
function PlayResultAnim(isSuccess)
	if isSuccess then
		Tex_Result:GetComponent("ExText").text = GetName(230135)
	else
		Tex_Result:GetComponent("ExText").text = GetName(230136)
	end
	Tex_Result:SetActive(false)
	Tex_Result:GetComponent("ExText").color = AlcoholColorProgress[10]
	Tex_Result:SetActive(true)
end
function GetName(NameID)
	return CS.Data.GetLang((NameID))
end
function GetIcon(iconCode)
	for i=0,ListSpriteWinePic.Count-1 do
		if ListSpriteWinePic[i].name == iconCode then
			return ListSpriteWinePic[i]
		end
	end
end
