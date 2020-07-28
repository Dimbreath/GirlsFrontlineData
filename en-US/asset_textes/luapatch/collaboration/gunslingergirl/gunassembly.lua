local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.TweenPlay)
xlua.private_accessible(CS.GF.Battle.BattleController)
xlua.private_accessible(CS.BattleFieldTeamHolder)
xlua.private_accessible(CS.DG.Tweening.TweenSettingsExtensions)
local GunPartsData = {}
local GunAssemblyData = {}

local AbleGunAssembly = {}
local AbleGunPartsID = {}
local CurrentGunPartsID = {} --玩家进入此战时 收集了哪些零件？
local CurrentGunPartsObject = {}
local CurGunPartsAssemblyFull
local CurrentGunPartsAssemblyObject = {}
local LastGunPartsAssemblyObject

local CurrentAssemblyID --正在拼哪个枪
local CurrentAssemblyCount = 0 --拼枪顺序
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
local btnContinue = nil

local inited = false
local waitAnimation = false
local waitAnimationCountdown = 0
local waitAnimationCountdownTimer = 0
local isPreviewing = true
local isPreviewingAnimation = false
local isEndingAnimation = false
local waitpreviewCountdown = 4
local waitpreviewCountdownTimer = 0
local waitpreviewAnimationCountdown = 0.5
local waitpreviewAnimationCountdownTimer = 0
local waitEndingAnimationCountdown = 2
local waitEndingAnimationCountdownTimer = 0
local waitTimeUpAnimationCountdown = 2
local waitTimeUpAnimationCountdownTimer = 0
local waitStampCountdown = 2
local waitStampCountdownTimer = 0
local isCountingTime = false
local isWaitTimeUp = false
local isWaitStamp = false
local ImgPreview

local mainTween1 = nil
local mainTween2 = nil

local successMat
local successMatValue = 1
local successMatChange = false
local msgbox = false

local score = 0

local TweenEase = xlua.get_generic_method(CS.DG.Tweening.TweenSettingsExtensions,"SetEase")
local TweenDelay = xlua.get_generic_method(CS.DG.Tweening.TweenSettingsExtensions,"SetDelay")
local TweenLoop = xlua.get_generic_method(CS.DG.Tweening.TweenSettingsExtensions,"SetLoops")
local PlayTween = xlua.get_generic_method(CS.DG.Tweening.TweenExtensions,"Play")
local SetEase = TweenEase(CS.DG.Tweening.Tweener)
local SetDelay = TweenDelay(CS.DG.Tweening.Tweener)
local SetLoops = TweenLoop(CS.DG.Tweening.Tweener)
local PlayTweener = PlayTween(CS.DG.Tweening.Tweener)
--CS.DG.Tweening.TweenSettingsExtensions.SetEase(tweener,(tweenplay.easeType))
--CS.DG.Tweening.TweenSettingsExtensions.SetDelay(tweener,tweenplay.delay)
--CS.DG.Tweening.TweenSettingsExtensions.SetLoops
--Awake：初始化数据
Awake = function()
	
	InitGunAssemblyData()	
	InitGunPartsData()
	CheckMissionBuffPart()
	
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
end
function InitGunAssemblyData()	
	local TableStruct = {ID = 1, Name = "M1897", GirlName = "ASSEMBLATO DA TRIELA",member = "1022,1023,1024", time = 60,code = "GunAssembly_M1897", score = 100}	
	GunAssemblyData[TableStruct.ID] = TableStruct	
	local TableStruct = {ID = 2, Name = "P90", GirlName = "ASSEMBLATO DA HENRIETTA",member = "1001,1002,1003,1004", time = 60,code = "GunAssembly_P90", score = 500}	
	GunAssemblyData[TableStruct.ID] = TableStruct	
	local TableStruct = {ID = 3, Name = "M249", GirlName = "ASSEMBLATO DA CLAES",member = "1005,1006,1007,1008,1009", time = 60,code = "GunAssembly_M249", score = 1000}	
	GunAssemblyData[TableStruct.ID] = TableStruct	
	local TableStruct = {ID = 4, Name = "AUG", GirlName = "ASSEMBLATO DA ANGELICA",member = "1010,1011,1012,1013,1014,1015", time = 60,code = "GunAssembly_AUG", score = 1500}	
	GunAssemblyData[TableStruct.ID] = TableStruct	
	local TableStruct = {ID = 5, Name = "SVD", GirlName = "ASSEMBLATO DA RICO",member = "1016,1017,1018,1019,1020,1021", time = 60,code = "GunAssembly_SVD", score = 1500}	
	GunAssemblyData[TableStruct.ID] = TableStruct	
end
function InitGunPartsData()	
	local TableStruct = {ID = 1001, buff_id = 381402, group_id = 2, weight = 4, limit = 5, isLimitUnder = false, code = "P90_Mag" ,waitTime = 1.683, isFirst = false, notfirst = false}	
	GunPartsData[1] = TableStruct
	
	TableStruct = {ID = 1002, buff_id = 381403, group_id = 2, weight = 3, limit = 4, isLimitUnder = true, code = "P90_Body",waitTime = 1.1, isFirst = false, notfirst = true}	
	GunPartsData[2] = TableStruct
	
	TableStruct = {ID = 1003, buff_id = 381404, group_id = 2, weight = 2, limit = 3, isLimitUnder = true, code = "P90_Bolt",waitTime = 0.9, isFirst = false, notfirst = true}	
	GunPartsData[3] = TableStruct
	
	TableStruct = {ID = 1004, buff_id = 381405, group_id = 2, weight = 1, limit = 1, isLimitUnder = true, code = "P90_Receiver",waitTime = 0.5, isFirst = true, notfirst = false}	
	GunPartsData[4] = TableStruct
	
	TableStruct = {ID = 1005, buff_id = 381406, group_id = 3, weight = 4, limit = 8, isLimitUnder = true, code = "M249_Stock",waitTime = 1, isFirst = false, notfirst = true}	
	GunPartsData[5] = TableStruct
	
	TableStruct = {ID = 1006, buff_id = 381407, group_id = 3, weight = 2, limit = 4, isLimitUnder = true, code = "M249_Trigger",waitTime = 1, isFirst = false, notfirst = true}	
	GunPartsData[6] = TableStruct
	
	TableStruct = {ID = 1007, buff_id = 381408, group_id = 3, weight = 5, limit = 8, isLimitUnder = false, code = "M249_Mag",waitTime = 0.9, isFirst = false, notfirst = false}	
	GunPartsData[7] = TableStruct
	
	TableStruct = {ID = 1008, buff_id = 381409, group_id = 3, weight = 1, limit = 1, isLimitUnder = true, code = "M249_Body",waitTime = 0.5, isFirst = true, notfirst = false}	
	GunPartsData[8] = TableStruct
	
	TableStruct = {ID = 1009, buff_id = 381410, group_id = 3, weight = 2, limit = 8, isLimitUnder = true, code = "M249_Barrel",waitTime = 1.733, isFirst = false, notfirst = true}	
	GunPartsData[9] = TableStruct
	
	TableStruct = {ID = 1010, buff_id = 381411, group_id = 4, weight = 3, limit = 3, isLimitUnder = true, code = "AUG_Bolt",waitTime = 0.9, isFirst = false, notfirst = true}	
	GunPartsData[10] = TableStruct
	
	TableStruct = {ID = 1011, buff_id = 381412, group_id = 4, weight = 1, limit = 1, isLimitUnder = true, code = "AUG_Receiver",waitTime = 0.5, isFirst = true, notfirst = false}	
	GunPartsData[11] = TableStruct
	
	TableStruct = {ID = 1012, buff_id = 381413, group_id = 4, weight = 2, limit = 0, isLimitUnder = false, code = "AUG_Body",waitTime = 1.4, isFirst = false, notfirst = false}	
	GunPartsData[12] = TableStruct
	
	TableStruct = {ID = 1013, buff_id = 381414, group_id = 4, weight = 7, limit = 16, isLimitUnder = false, code = "AUG_Mag",waitTime = 0.95, isFirst = false, notfirst = false}	
	GunPartsData[13] = TableStruct
	
	TableStruct = {ID = 1014, buff_id = 381415, group_id = 4, weight = 5, limit = 3, isLimitUnder = false, code = "AUG_Barrel",waitTime = 1, isFirst = false, notfirst = false}	
	GunPartsData[14] = TableStruct
	
	TableStruct = {ID = 1015, buff_id = 381416, group_id = 4, weight = 6, limit = 9, isLimitUnder = false, code = "AUG_Bipod",waitTime = 0.7, isFirst = false, notfirst = false}	
	GunPartsData[15] = TableStruct
	
	TableStruct = {ID = 1016, buff_id = 381417, group_id = 5, weight = 8, limit = 6, isLimitUnder = true, code = "SVD_Upper",waitTime = 1, isFirst = false, notfirst = true}	
	GunPartsData[16] = TableStruct
	
	TableStruct = {ID = 1017, buff_id = 381418, group_id = 5, weight = 5, limit = 0, isLimitUnder = false, code = "SVD_Scope",waitTime = 0.75, isFirst = false, notfirst = false}
	GunPartsData[17] = TableStruct
	
	TableStruct = {ID = 1018, buff_id = 381419, group_id = 5, weight = 2, limit = 0, isLimitUnder = false, code = "SVD_HG",waitTime = 1, isFirst = false, notfirst = false}	
	GunPartsData[18] = TableStruct
	
	TableStruct = {ID = 1019, buff_id = 381420, group_id = 5, weight = 2, limit = 4, isLimitUnder = true, code = "SVD_Trigger",waitTime = 1.167, isFirst = false, notfirst = true}	
	GunPartsData[19] = TableStruct
	
	TableStruct = {ID = 1020, buff_id = 381421, group_id = 5, weight = 5, limit = 10, isLimitUnder = false, code = "SVD_Mag",waitTime = 1, isFirst = false, notfirst = false}	
	GunPartsData[20] = TableStruct
	
	TableStruct = {ID = 1021, buff_id = 381422, group_id = 5, weight = 1, limit = 1, isLimitUnder = true, code = "SVD_Lower",waitTime = 0.5, isFirst = true, notfirst = false}	
	GunPartsData[21] = TableStruct
	
	TableStruct = {ID = 1022, buff_id = 381423, group_id = 1, weight = 1, limit = 1, isLimitUnder = true, code = "M1897_Receiver",waitTime = 0.5, isFirst = true, notfirst = false}	
	GunPartsData[22] = TableStruct
	
	TableStruct = {ID = 1023, buff_id = 381424, group_id = 1, weight = 2, limit = 0, isLimitUnder = false, code = "M1897_Stock",waitTime = 1.2, isFirst = false, notfirst = false}	
	GunPartsData[23] = TableStruct
	
	TableStruct = {ID = 1024, buff_id = 381425, group_id = 1, weight = 2, limit = 0, isLimitUnder = false, code = "M1897_Barrel",waitTime = 1, isFirst = false, notfirst = false}	
	GunPartsData[24] = TableStruct
	
	
end
function TestMissionBuffPart()
	local cnt = 1
	for j=1,4 do
		CurrentGunPartsID[cnt] = GunPartsData[j].ID
		cnt = cnt + 1		
	end
end
function CheckMissionBuffPart()
	local cnt = 1
	local listBuffAction = CS.GF.Battle.BattleController.Instance.currentSpotAction.listEnemyBuffAction
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
	btnContinue = BtnContinue:GetComponent(typeof(CS.ExButton))
	local btnEndgame = BtnEndgame:GetComponent(typeof(CS.ExButton))
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
	btnContinue.onClick:AddListener(
		function()
			ContinueAssembly()
		end)
	btnEndgame.onClick:AddListener(
		function()
			ResultEndGame()
		end)
	
	local mainTweens = MainGO:GetComponents(typeof(CS.TweenPlay))
	mainTween1 = mainTweens[0]
	mainTween2 = mainTweens[1]
	TimeGO:SetActive(false)
	ScoreGO:SetActive(false)
	--根据已经收集的零件判断玩家现在可以拼哪把枪 并初始化倒计时
	CalcGunAssemblyCount()
	CheckAbleAssembly()
	--初始化零件显示
	self.transform:SetParent(CS.BattleUIController.Instance.transform:Find('UI'),false)
	CS.BattleFrameManager.StopTime(true,99999)
	btnReset.gameObject:SetActive(false)
	btnUndo.gameObject:SetActive(false)
	btnBack.gameObject:SetActive(false)
	CS.CommonAudioController.PlayBGM("GF_xGS2_22")
	inited = true
	
end
--Update: 计算倒计时
Update = function()
	if inited then
		if isPreviewing then
			waitpreviewCountdownTimer =  waitpreviewCountdownTimer + CS.UnityEngine.Time.deltaTime
			if isPreviewing and  waitpreviewCountdownTimer > waitpreviewCountdown then
				isPreviewing = false
				EndPreview()
			end
		else
			if isPreviewingAnimation then
				waitpreviewAnimationCountdownTimer = waitpreviewAnimationCountdownTimer+ CS.UnityEngine.Time.deltaTime
				if isPreviewingAnimation and  waitpreviewAnimationCountdownTimer > waitpreviewAnimationCountdown then
					isPreviewingAnimation = false
					EndPreviewAnimation()
				end
			else
				if isCountingTime then
					countdownTimer = countdownTimer + CS.UnityEngine.Time.deltaTime
					TextCountdown:GetComponent(typeof(CS.ExText)).text = string.format("%.2f",(countdown - countdownTimer))
				end
				if isEndingAnimation then
					waitEndingAnimationCountdownTimer = waitEndingAnimationCountdownTimer + CS.UnityEngine.Time.deltaTime
					if isEndingAnimation and  waitEndingAnimationCountdownTimer > waitEndingAnimationCountdown then
						isEndingAnimation = false
						EndEndingAnimation()
					end
				end
				
				if countdownTimer > countdown then
					isCountingTime = false
					countdownTimer = countdown
					PlaySFX("CountdownCancel")
					EndAssembly()
				end
				
				if waitAnimation then
					waitAnimationCountdownTimer = waitAnimationCountdownTimer + CS.UnityEngine.Time.deltaTime
					if waitAnimationCountdownTimer > waitAnimationCountdown then
						waitAnimation = false
						waitAnimationCountdownTimer = 0
						CheckAssemblyGunComplete()
						if #AssemblyGunPartsIDList == 0 then
							ResetAssembly()
						end
					end
				end
				if isWaitTimeUp then
					waitTimeUpAnimationCountdownTimer = waitTimeUpAnimationCountdownTimer + CS.UnityEngine.Time.deltaTime
					if waitTimeUpAnimationCountdownTimer > waitTimeUpAnimationCountdown then
						isWaitTimeUp = false
						TimeupGO:SetActive(false)
						ShowResult()
					end
				end
				if isWaitStamp then
					waitStampCountdownTimer = waitStampCountdownTimer + CS.UnityEngine.Time.deltaTime
					if waitStampCountdownTimer > waitStampCountdown then
						isWaitStamp = false
						PlaySFX("captured")
					end
				end
				--if 	successMatChange then
				--	successMat:SetFloat("_Guodu", successMatValue)
				--	successMatValue = successMatValue - 0.5 * CS.UnityEngine.Time.deltaTime
				--	if successMatValue <= 0 then
				--		successMat:SetFloat("_Guodu", 0)
				--		successMatChange = false
				--	end
				--end
			end
			
		end
		
	end
end

function EndPreviewAnimation()
	
	DoTweenFade(ImgPreview:GetComponent(typeof(CS.ExImage)))
	ShowGunParts()
	ResetAssembly()
	TimeGO:SetActive(true)
	ScoreGO:SetActive(true)
	isCountingTime = true
	PlaySFX("Countdown")
	btnReset.gameObject:SetActive(true)
	btnUndo.gameObject:SetActive(true)
	btnBack.gameObject:SetActive(true)
	ImgPreview:SetActive(false)
	AddFirstGunParts()
end
function EndPreview()
	DoTweenPlay(mainTween1,MainGO)
	isPreviewingAnimation = true
end
function EndEndingAnimation()
	btnContinue.gameObject:SetActive(true)
end
function OnClickAssemblyEnd()
	--弹出提示
	if GunAssemblyCount == 0 then
		CS.CommonController.ConfirmBox(GetName(10162),function()
				EndAssembly()
			end,nil,CS.ConfirmType.Normal,0,true)
	else
		CS.CommonController.ConfirmBox(GetName(10165),function()
				EndAssembly()
			end)
	end
end
function ContinueAssembly()
	
	if GunAssemblyCount >= GunAssemblyAbleCount then
		EndAssembly()
	else	
		
		local data = GetGunAssemblyDataById(CurrentAssemblyID)
		if data ~= nil then			
			local ImgSuccess
			if data.Name == "SVD" then
				ImgSuccess = ImgSuccessSVD
			end	
			if data.Name == "M249" then
				ImgSuccess = ImgSuccessM249
			end	
			if data.Name == "M1897" then
				ImgSuccess = ImgSuccessM1897
			end	
			if data.Name == "AUG" then
				ImgSuccess = ImgSuccessAUG
			end	
			if data.Name == "P90" then
				ImgSuccess = ImgSuccessP90
			end	
			ImgSuccess:SetActive(false)
		end
		btnContinue.gameObject:SetActive(false)
		waitpreviewCountdown = 4
		waitpreviewCountdownTimer = 0
		waitpreviewAnimationCountdown = 0.5
		waitpreviewAnimationCountdownTimer = 0
		waitEndingAnimationCountdown = 2	
		waitEndingAnimationCountdownTimer = 0
		if not (CurGunPartsAssemblyFull == nil) then
			CS.UnityEngine.Object.Destroy(CurGunPartsAssemblyFull.gameObject)
			CurGunPartsAssemblyFull = nil
		end	
		CheckAbleAssembly()
	end
end
--结束拼枪：倒计时结束 或玩家点击后退按钮 或玩家拼完了所有可以拼的枪
function EndAssembly()
	
	if GunAssemblyCount == 0 then
		CS.BattleFrameManager.ResumeTime()
		PlaySFX("fail")
		PlaySFX("CountdownCancel")
		CS.GF.Battle.BattleController.Instance:TriggerBattleFinishEvent(true)
	else
		if countdownTimer >= countdown then
			TimeupGO:SetActive(true)
			isWaitTimeUp = true
			PlaySFX("fail")
		else
			ShowResult()
		end
		
	end
	
end
--初始化/重置数据 注意不重新计算倒计时 也不重置已经拼好的...
function ResetAssembly()
	lastGunPartsID = 0
	gunWeight = 0
	for i=1,#CurrentGunPartsObject do
		GunPartShowStep(CurrentGunPartsObject[i],0)
	end
	AssemblyGunPartsIDList = {}
	CurrentGunPartsAssemblyObject = {}
	LastGunPartsAssemblyObject = nil
	if not (CurGunPartsAssemblyFull == nil) then
		CS.UnityEngine.Object.Destroy(CurGunPartsAssemblyFull.gameObject)
		CurGunPartsAssemblyFull = nil
	end
	waitAnimation = false
	waitAnimationCountdownTimer = 0
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
	if waitAnimation then
		CS.CommonController.LightMessageTips(GetName(10164))
		return
	end
	local data = GetGunPartsDataById(id)
	if data == nil then
		return
	end
	if id == lastGunPartsID then
		ReturnLastGunParts()
	else
		if (CheckLimit(data)) then
			AddGunParts(id)
		else
			--弹出提示
			CS.CommonController.LightMessageTips(GetName(10161))
		end
	end
	
end
function CheckLimit(data)
	if data.notfirst then
		if gunWeight == 0 then
			return false
		end
	end
	if data.isfirst then
		return true
	end
	if data.isLimitUnder then
		if gunWeight < data.limit then
			return true
		else
			return false
		end		
	else
		if gunWeight > data.limit then
			return true
		else
			return false
		end	
	end
end
function AddGunParts(id)
	local data = GetGunPartsDataById(id)
	local AssemblyData = GetGunAssemblyDataById(CurrentAssemblyID)
	local firstflag = false
	if CurGunPartsAssemblyFull == nil then
		CurGunPartsAssemblyFull = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("WorldCollide/GunslingerGirl/"..AssemblyData.code))
		CurGunPartsAssemblyFull.transform:SetParent(GunPartHolder.transform,false)
		CurGunPartsAssemblyFull:SetLayerRecursively(18)
		PlaySFX("pickup")
		firstflag = true
	end
	
	for i=1,#AssemblyGunPartsIDList do
		if AssemblyGunPartsIDList[i] == id then
			return
		end
	end
	if firstflag == false then
		PlaySFX("metal")
	end
	AssemblyGunPartsIDList[#AssemblyGunPartsIDList + 1] = id
	lastGunPartsID =AssemblyGunPartsIDList[#AssemblyGunPartsIDList]
	local cnt = 0
	for i=1,#CurrentGunPartsID do
		local dataCnt = GetGunPartsDataById(CurrentGunPartsID[i])
		if dataCnt.group_id == CurrentAssemblyID then
			cnt = cnt +1		
			if CurrentGunPartsID[i] == id  then
				print(cnt.." "..#CurrentGunPartsObject)
				gunWeight = gunWeight + GetGunPartsDataById(id).weight
				GunPartShowStep(CurrentGunPartsObject[cnt],#AssemblyGunPartsIDList)
			end
		end
	end
	local AssemblyGunPartsObject =  CurGunPartsAssemblyFull.transform:Find(data.code).gameObject
	local tweens = AssemblyGunPartsObject:GetComponents(typeof(CS.TweenPlay))
	for i=0,tweens.Length-1 do
		tweens[i]:SetIsPlayBackwards(false)
	end
	if AssemblyGunPartsObject.activeSelf then
		AssemblyGunPartsObject:SetActive(false)
		AssemblyGunPartsObject:SetActive(true)
	else
		AssemblyGunPartsObject:SetActive(true)
	end
	local AssemblyGunPartsObjectShadow =  CurGunPartsAssemblyFull.transform:Find("Shadow"):Find(data.code).gameObject
	tweens = AssemblyGunPartsObjectShadow:GetComponents(typeof(CS.TweenPlay))
	for i=0,tweens.Length-1 do
		tweens[i]:SetIsPlayBackwards(false)
	end
	if AssemblyGunPartsObjectShadow.activeSelf then
		AssemblyGunPartsObjectShadow:SetActive(false)
		AssemblyGunPartsObjectShadow:SetActive(true)
	else
		AssemblyGunPartsObjectShadow:SetActive(true)
	end
	CurrentGunPartsAssemblyObject[#CurrentGunPartsAssemblyObject+1] = AssemblyGunPartsObject
	LastGunPartsAssemblyObject = CurrentGunPartsAssemblyObject[#CurrentGunPartsAssemblyObject]
	waitAnimation = true
	waitAnimationCountdown = data.waitTime + 0.1
	--local tweenplays = AssemblyGunPartsObject:GetComponents(typeof(CS.TweenPlay))
	--for i=0,tweenplays.Length-1 do
	--	DoTweenPlay(tweenplays[i],AssemblyGunPartsObject,false)
	--end
end
function DoTweenFade(image)
	local tweener = CS.DG.Tweening.ShortcutExtensions46.DOFade(image,0,0.3)
	PlayTweener(tweener)
end
function DoTweenPlay(tweenplay,gameobject,isreverse)
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.Alpha then
		local value = tweenplay.toOne
		if isreverse then 
			value = tweenplay.fromOne
		end
		if gameobject:GetComponent(typeof(CS.UnityEngine.CanvasGroup)) == nil then
			gameobject:AddComponent(typeof(CS.UnityEngine.CanvasGroup))	
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions46.DOFade
		(gameobject:GetComponent(typeof(CS.UnityEngine.CanvasGroup)),value,tweenplay.duration)
		SetEase(tweener,(tweenplay.easeType))
		SetDelay(tweener,tweenplay.delay)
		SetLoops(tweener,tweenplay.loopTime,tweenplay.loopType)
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		PlayTweener(tweener)
	end
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.PositionYLocal then
		local value = tweenplay.toOne
		if isreverse then 
			value = tweenplay.fromOne
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions.DOLocalMoveY
		(gameobject.transform,value,tweenplay.duration)
		SetEase(tweener,(tweenplay.easeType))
		SetDelay(tweener,tweenplay.delay)
		SetLoops(tweener,tweenplay.loopTime,tweenplay.loopType)
		
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		PlayTweener(tweener)
	end
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.PositionLocal then
		local value = tweenplay.toThree
		if isreverse then 
			value = tweenplay.fromThree
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions46.DOAnchorPos3D
		(gameobject:GetComponent(typeof(CS.UnityEngine.RectTransform)),tweenplay.toThree,tweenplay.duration)
		SetEase(tweener,(tweenplay.easeType))
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		PlayTweener(tweener)
	end
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.Rotation then
		local value = tweenplay.toThree
		if isreverse then 
			value = tweenplay.fromThree
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions.DORotate
		(gameobject.transform,tweenplay.toThree,tweenplay.duration,CS.DG.Tweening.RotateMode.WorldAxisAdd)
		SetEase(tweener,(tweenplay.easeType))
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		PlayTweener(tweener)
	end
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.Scale then
		local value = tweenplay.toThree
		if isreverse then 
			value = tweenplay.fromThree
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions.DOScale
		(gameobject.transform,tweenplay.toThree,tweenplay.duration)
		SetEase(tweener,(tweenplay.easeType))
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		PlayTweener(tweener)
	end
end
function CheckAssemblyGunComplete()
	local data = GetGunAssemblyDataById(CurrentAssemblyID)
	local assemblyMemberArray = Split(data.member,',')
	for i=1, #assemblyMemberArray do
		local id = tonumber(assemblyMemberArray[i])
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
	CurrentGunPartsObject = {}
	GunAssemblyCount = GunAssemblyCount +1
	btnReset.gameObject:SetActive(false)
	btnUndo.gameObject:SetActive(false)
	GetScore(data.score)
	if GunAssemblyCount >= GunAssemblyAbleCount then
		btnBack.gameObject:SetActive(false)
	else
		btnBack.gameObject:SetActive(true)
	end
	
	PlaySFX("CountdownCancel")
	PlaySFX("success")
	isCountingTime = false
	DoTweenPlay(mainTween2,MainGO)
	isEndingAnimation = true
	local ImgSuccess
	if data.Name == "SVD" then
		ImgSuccess = ImgSuccessSVD
	end	
	if data.Name == "M249" then
		ImgSuccess = ImgSuccessM249
	end	
	if data.Name == "M1897" then
		ImgSuccess = ImgSuccessM1897
	end	
	if data.Name == "AUG" then
		ImgSuccess = ImgSuccessAUG
	end	
	if data.Name == "P90" then
		ImgSuccess = ImgSuccessP90
	end	
	ImgSuccess:SetActive(true)
	
	
	
end
function ReturnLastGunParts()	
	
	lastGunPartsID =AssemblyGunPartsIDList[#AssemblyGunPartsIDList]
	local cnt = 0
	for i=1,#CurrentGunPartsID do
		local dataCnt = GetGunPartsDataById(CurrentGunPartsID[i])
		if dataCnt.group_id == CurrentAssemblyID then
			cnt = cnt + 1
			print(cnt.." "..#CurrentGunPartsObject)
			if CurrentGunPartsID[i] == lastGunPartsID then
				GunPartShowStep(CurrentGunPartsObject[cnt],0)
				break
			end
		end
	end
	if GetGunPartsDataById(lastGunPartsID) == nil then
		return
	end
	gunWeight = gunWeight - GetGunPartsDataById(lastGunPartsID).weight
	
	local AssemblyGunPartsObject = CurrentGunPartsAssemblyObject[#CurrentGunPartsAssemblyObject]
	--local eximages = AssemblyGunPartsObject:GetComponentsInChildren(typeof(CS.ExImage))
	--for i=0,eximages.Length-1 do
	--	DoTweenFade(eximages[i])
	--end
	--local AssemblyGunPartsObjectShadow = CurGunPartsAssemblyFull.transform:Find("Shadow"):Find(AssemblyGunPartsObject.name)
	--eximages = AssemblyGunPartsObjectShadow:GetComponentsInChildren(typeof(CS.ExImage))
	--for i=0,eximages.Length-1 do
	--	DoTweenFade(eximages[i])
	--end
	local data = GetGunPartsDataById(lastGunPartsID)
	local tweenUndo = true
	local UndoGO = CurGunPartsAssemblyFull.transform:Find("Undo_"..AssemblyGunPartsObject.name)
	if UndoGO == nil then
		tweenUndo = true
	else
		tweenUndo = false
	end
	if tweenUndo then
		local tweens = AssemblyGunPartsObject:GetComponents(typeof(CS.TweenPlay))
		for i=0,tweens.Length-1 do
			if tweens[i].currentTweenMode == CS.TweenPlay.TweenMode.Rotation then
				local tweener = CS.DG.Tweening.ShortcutExtensions.DORotate
				(AssemblyGunPartsObject.transform,tweens[i].toThree,tweens[i].duration,CS.DG.Tweening.RotateMode.WorldAxisAdd)
				SetEase(tweener,(tweens[i].easeType))
				PlayTweener(tweener)
			else		
				tweens[i]:SetIsPlayBackwards(true):DoTween()
			end
		end
		local AssemblyGunPartsObjectShadow = CurGunPartsAssemblyFull.transform:Find("Shadow"):Find(AssemblyGunPartsObject.name)
		local tweensShadow = AssemblyGunPartsObjectShadow.gameObject:GetComponents(typeof(CS.TweenPlay))
		if tweensShadow ~= nil then
			print(tweensShadow.Length)
			for j=0,tweensShadow.Length-1 do
				if tweensShadow[j] ~= nil then					
					if tweensShadow[j].currentTweenMode == CS.TweenPlay.TweenMode.Rotation then
						local tweener = CS.DG.Tweening.ShortcutExtensions.DORotate
						(AssemblyGunPartsObjectShadow.transform,tweensShadow[j].toThree,tweensShadow[j].duration,CS.DG.Tweening.RotateMode.WorldAxisAdd)
						SetEase(tweener,(tweensShadow[j].easeType))
						PlayTweener(tweener)
					else	
						tweensShadow[j]:SetIsPlayBackwards(true):DoTween()
					end
				else
					print("Tween is nil")
				end
			end
		else
			print("Tween not found")
		end
		
	else
		UndoGO.gameObject:SetActive(false)
		UndoGO.gameObject:SetActive(true)
		--AssemblyGunPartsObject:SetActive(false)
		
	end
	table.remove(CurrentGunPartsAssemblyObject)
	
	LastGunPartsAssemblyObject = CurrentGunPartsAssemblyObject[#CurrentGunPartsAssemblyObject]
	waitAnimation = true
	waitAnimationCountdown = 0.5
	table.remove(AssemblyGunPartsIDList)
	if #AssemblyGunPartsIDList > 0 then
		lastGunPartsID =AssemblyGunPartsIDList[#AssemblyGunPartsIDList]
	end
	
end	

function CheckAbleAssembly()
	
	CurrentAssemblyCount = CurrentAssemblyCount + 1
	ShowGunAssembly(AbleGunAssembly[CurrentAssemblyCount])		
	
end
function ShowGunAssembly(GunAssemblyData)
	TextGunName:GetComponent(typeof(CS.ExText)).text = tostring(GunAssemblyData.Name)
	TextGunslingerName:GetComponent(typeof(CS.ExText)).text = tostring(GunAssemblyData.GirlName)
	CurrentAssemblyID = GunAssemblyData.ID
	print(GunAssemblyData.Name)
	if GunAssemblyData.Name == "SVD" then
		ImgPreview = ImgPreviewSVD
	end	
	if GunAssemblyData.Name == "M249" then
		ImgPreview = ImgPreviewM249
	end	
	if GunAssemblyData.Name == "M1897" then
		ImgPreview = ImgPreviewM1897
	end	
	if GunAssemblyData.Name == "AUG" then
		ImgPreview = ImgPreviewAUG
	end	
	if GunAssemblyData.Name == "P90" then
		ImgPreview = ImgPreviewP90
	end	
	local arrmat = CS.UnityEngine.Material(CS.UnityEngine.Shader.Find("Unlit/UGUITexComplex"))
	ImgPreview:GetComponent(typeof(CS.ExImage)).material = arrmat
	ImgPreview:SetActive(true)
	--local Tweens = ImgPreview:GetComponents(typeof(CS.TweenPlay))
	--Tweens[0]:DoTween()
	--Tweens[1]:DoTween()
	isPreviewing = true
end
function CalcGunAssemblyCount()
	GunAssemblyCount = 0
	GunAssemblyAbleCount = 0
	local GunAssemblyAbleID = -1
	countdown = 100000
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
			print(GunAssemblyAbleCount..GunAssemblyData[i].Name)
			AbleGunAssembly[GunAssemblyAbleCount] = GunAssemblyData[i]
			if countdown > GunAssemblyData[i].time then
				countdown = GunAssemblyData[i].time
			end						
		end
	end
	if GunAssemblyAbleCount == 0 and not msgbox then
		msgbox = true
		CS.CommonController.MessageBox("零件不够",function()
				EndAssembly()
			end)
	end
end
function ShowGunParts()
	for i=1,#CurrentGunPartsID do
		local data = GetGunPartsDataById(CurrentGunPartsID[i])		
		if data.group_id == CurrentAssemblyID then
			local subpart = CS.UnityEngine.Object.Instantiate(GOGunPart)
			subpart.gameObject.transform:SetParent(GOGunPartHolder.transform,false)
			subpart.gameObject:SetActive(true)
			subpart.transform:Find("Icon").gameObject:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/" .. data.code)
			subpart:GetComponent(typeof(CS.ExButton)).onClick:AddListener(
				function()
					OnClickGunParts(CurrentGunPartsID[i])
				end)
			CurrentGunPartsObject[#CurrentGunPartsObject+1] = subpart
			GunPartShowStep(subpart,0)
		end
		
	end
end
function AddFirstGunParts()
	for i=1,#CurrentGunPartsID do
		local data = GetGunPartsDataById(CurrentGunPartsID[i])	
		if data.group_id == CurrentAssemblyID then
			if data.isFirst then
				OnClickGunParts(CurrentGunPartsID[i])
				return
			end
		end	
		
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
		gunpart.transform:Find("Tex_Step").gameObject:GetComponent(typeof(CS.ExText)).text = GetShownNum(step)
	end
	
end

function GetScore(scorenum)
	score = score + scorenum
	local tweenNum = TextScore:GetComponent(typeof(CS.TweenNumber))
	tweenNum.NumberTo = score
	CS.DG.Tweening.ShortcutExtensions.DOKill(tweenNum)
	tweenNum:Play()
end

function ShowResult()
	isCountingTime = false
	PlaySFX("CountdownCancel")
	PlaySFX("success")
	if Result.activeSelf then
		return
	end
	Frame:SetActive(false)
	Result:SetActive(true)
	TextResultName:GetComponent(typeof(CS.ExText)).text = CS.GameData.userInfo.name
	TextResultID:GetComponent(typeof(CS.ExText)).text = CS.GameData.userInfo.userId
	
	local tweenNum = TextResultTime:GetComponent(typeof(CS.TweenNumber))
	tweenNum.NumberToString = string.format("%.2f",(countdownTimer))
	CS.DG.Tweening.ShortcutExtensions.DOKill(tweenNum)
	tweenNum:Play()
	
	local tweenNum2 = TextResultScore:GetComponent(typeof(CS.TweenNumber))
	tweenNum2.NumberToString = score
	CS.DG.Tweening.ShortcutExtensions.DOKill(tweenNum2)
	tweenNum2:Play()
	if score >= 4600 then
		ImgResultMedal:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/medal_gold")
		ImgResultMedal:GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,1,1,1)
		ImgResultMedal:SetActive(true)
		ImgResultSeal:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/seal_expert")
		ImgResultRating:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/rating_expert")
	else if score >= 1600 then
			ImgResultMedal:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/medal_silver")
			ImgResultMedal:GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,1,1,1)
			ImgResultMedal:SetActive(true)
			ImgResultSeal:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/seal_advanced")
			ImgResultRating:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/rating_advanced")
		else if score > 0 then
				ImgResultSeal:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/seal_basic")
				ImgResultRating:GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("WorldCollide/GunslingerGirl/Icon/rating_basic")
			end
		end
	end
	isWaitStamp = true
end
function ResultEndGame()
	CS.BattleFrameManager.ResumeTime()
	for i=0,CS.GF.Battle.BattleController.Instance.enemyTeamHolder.listCharacter.Count-1 do
		local DamageInfo = CS.GF.Battle.BattleDamageInfo()
		CS.GF.Battle.BattleController.Instance.enemyTeamHolder.listCharacter[i]:UpdateLife(DamageInfo, -999999)
	end
	CS.UnityEngine.Object.Destroy(self.gameObject)
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
	
	if FXname == "Countdown" then
		CS.CommonAudioController.PlayUI("UI_GunslingerGirl_Countdown_loop")
	end
	if FXname == "success" then
		CS.CommonAudioController.PlayUI("UI_GunslingerGirl_succeed")
	end
	if FXname == "fail" then
		CS.CommonAudioController.PlayUI("UI_GunslingerGirl_fail")
	end
	if FXname == "pickup" then
		CS.CommonAudioController.PlayUI("UI_GunslingerGirl_Pick_Up_Component")
	end
	if FXname == "metal" then
		CS.CommonAudioController.PlayUI("UI_GunslingerGirl_Assemble_Metal")
	end
	if FXname == "wood" then
		CS.CommonAudioController.PlayUI("UI_GunslingerGirl_Assemble_Wood")
	end
	if FXname == "CountdownCancel" then
		CS.CommonAudioController.PlayUI("UI_GunslingerGirl_Countdown_stop")
	end
	if FXname == "captured" then
		CS.CommonAudioController.PlayUI("UI_GunslingerGirl_captured")
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
function GetShownNum(num)
	if num == 1 then
		return "Uno"
	end
	if num == 2 then
		return "Due"
	end
	if num == 3 then
		return "Tre"
	end
	if num == 4 then
		return "Quattro"
	end
	if num == 5 then
		return "Cinque"
	end
	if num == 6 then
		return "Sei"
	end
	if num == 7 then
		return "Sette"
	end
	if num == 8 then
		return "Otto"
	end
	if num == 9 then
		return "Nove"
	end
	if num == 10 then
		return "Dieci"
	end
end

function GetName(NameID)
	return CS.Data.GetLang((NameID))
end

