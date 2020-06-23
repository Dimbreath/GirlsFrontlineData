local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.TweenPlay)
xlua.private_accessible(CS.GF.Battle.BattleController)
xlua.private_accessible(CS.BattleFieldTeamHolder)
xlua.private_accessible(CS.DG.Tweening.TweenSettingsExtensions)
local GunPartsData = {}
local GunAssemblyData = {}

local CurrentGunPartsID = {} --玩家进入此战时 收集了哪些零件？
local CurrentGunPartsObject = {}
local CurGunPartsAssemblyFull
local CurrentGunPartsAssemblyObject = {}
local LastGunPartsAssemblyObject

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
local btnContinue = nil

local inited = false
local waitAnimation = false
local tempDirector
local reverseDirector = false
local waitAnimationCountdown = 0
local waitAnimationCountdownTimer = 0
local isPreviewing = true
local isPreviewingAnimation = false
local isEndingAnimation = false
local waitpreviewCountdown = 4
local waitpreviewCountdownTimer = 0
local waitpreviewAnimationCountdown = 2
local waitpreviewAnimationCountdownTimer = 0
local waitEndingAnimationCountdown = 2
local waitEndingAnimationCountdownTimer = 0
local isCountingTime = false
local ImgPreview

local mainTween1 = nil
local mainTween2 = nil

local successMat
local successMatValue = 1
local successMatChange = false
--Awake：初始化数据
Awake = function()
	
	InitGunAssemblyData()	
	InitGunPartsData()
	TestMissionBuffPart()
	
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
end
function InitGunAssemblyData()	
	local TableStruct = {ID = 1, Name = "SVD", GirlName = "ASSEMBLATO DA HENRIETTA",member = "1001,1002,1003,1004,1005,1006", time = 6000,code = "GunAssembly_SVD", previewID = 4}	
	GunAssemblyData[TableStruct.ID] = TableStruct	
	
end
function InitGunPartsData()	
	local TableStruct = {ID = 1001, buff_id = 987001, group_id = 1, weight = 4, limit = 3, isLimitUnder = false, code = "SVD_Upper" ,waitTime = 1}	
	GunPartsData[1] = TableStruct
	
	TableStruct = {ID = 1002, buff_id = 987002, group_id = 1, weight = 5, limit = 7, isLimitUnder = false, code = "SVD_Scope",waitTime = 0.75}	
	GunPartsData[2] = TableStruct
	
	TableStruct = {ID = 1003, buff_id = 987003, group_id = 1, weight = 1, limit = 1, isLimitUnder = false, code = "SVD_HG",waitTime = 1}	
	GunPartsData[3] = TableStruct
	
	TableStruct = {ID = 1004, buff_id = 987004, group_id = 1, weight = 2, limit = 1, isLimitUnder = false, code = "SVD_Trigger",waitTime = 1.167}	
	GunPartsData[4] = TableStruct
	
	TableStruct = {ID = 1005, buff_id = 987005, group_id = 1, weight = 1, limit = 3, isLimitUnder = false, code = "SVD_Mag",waitTime = 1}	
	GunPartsData[5] = TableStruct
	
	TableStruct = {ID = 1006, buff_id = 987006, group_id = 1, weight = 1, limit = 0, isLimitUnder = false, code = "SVD_Lower",waitTime = 0.5}	
	GunPartsData[6] = TableStruct
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
		print(missionBuffId)
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
			EndAssembly()
		end)
	

	local mainTweens = MainGO:GetComponents(typeof(CS.TweenPlay))
	mainTween1 = mainTweens[0]
	mainTween2 = mainTweens[1]
	TimeGO:SetActive(false)
	--根据已经收集的零件判断玩家现在可以拼哪把枪 并初始化倒计时
	CalcGunAssemblyCount()
	--初始化零件显示
	self.transform:SetParent(CS.BattleUIController.Instance.transform:Find('UI'),false)
	CS.BattleFrameManager.StopTime(true,99999)


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
					EndAssembly()
				end
				if reverseDirector then
					local time = tempDirector.time - CS.UnityEngine.Time.deltaTime
					if time < 0 then 
						time = 0
					end
					tempDirector.time = time
					tempDirector:DeferredEvaluate()
					if tempDirector.time <= 0 then
						reverseDirector = false
					end
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
				if 	successMatChange then
					successMat:SetFloat("_Guodu", successMatValue)
					successMatValue = successMatValue - 0.5 * CS.UnityEngine.Time.deltaTime
					if successMatValue <= 0 then
						successMat:SetFloat("_Guodu", 0)
						successMatChange = false
					end
				end
			end
			
		end
		
	end
end
 
function EndPreviewAnimation()

	DoTweenFade(ImgPreview:GetComponent(typeof(CS.ExImage)))
	ShowGunParts()
	ResetAssembly()
	TimeGO:SetActive(true)
	isCountingTime = true
	PlaySFX("Countdown")
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
	CS.BattleFrameManager.ResumeTime()
	if GunAssemblyCount == 0 then
		PlaySFX("fail")
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
	CurrentGunPartsAssemblyObject = {}
	LastGunPartsAssemblyObject = nil
	if not (CurGunPartsAssemblyFull == nil) then
		CS.UnityEngine.Object.Destroy(CurGunPartsAssemblyFull.gameObject)
		CurGunPartsAssemblyFull = nil
	end
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
		return
	end
	local data = GetGunPartsDataById(id)
	if data == nil then
		return
	end
	if id == lastGunPartsID then
		ReturnLastGunParts()
	else
		if (data.isLimitUnder and data.limit >= gunWeight) or (not data.isLimitUnder and data.limit <= gunWeight) then
			AddGunParts(id)
		else
			--弹出提示
			print(data.limit .." "..gunWeight)
			CS.CommonController.LightMessageTips("顺序不正确不能拼装")
		end
	end
	
end
function AddGunParts(id)
	local data = GetGunPartsDataById(id)
	if CurrentAssemblyID == -1 then
		CurrentAssemblyID = data.group_id
		local AssemblyData = GetGunAssemblyDataById(CurrentAssemblyID)
		if CurGunPartsAssemblyFull == nil then
			CurGunPartsAssemblyFull = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("WorldCollide/GunslingerGirl/"..AssemblyData.code))
			CurGunPartsAssemblyFull.transform:SetParent(GunPartHolder.transform,false)
			CurGunPartsAssemblyFull:SetLayerRecursively(18)
		end
		PlaySFX("pickup")
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
	PlaySFX("metal")
	AssemblyGunPartsIDList[#AssemblyGunPartsIDList + 1] = id
	lastGunPartsID =AssemblyGunPartsIDList[#AssemblyGunPartsIDList]
	for i=1,#CurrentGunPartsID do
		if CurrentGunPartsID[i] == id then
			gunWeight = gunWeight + GetGunPartsDataById(id).weight
			GunPartShowStep(CurrentGunPartsObject[i],#AssemblyGunPartsIDList)
		end
	end
	local AssemblyGunPartsObject =  CurGunPartsAssemblyFull.transform:Find(data.code).gameObject
	if AssemblyGunPartsObject.activeSelf then
		AssemblyGunPartsObject:SetActive(false)
		AssemblyGunPartsObject:SetActive(true)
	else
		AssemblyGunPartsObject:SetActive(true)
	end
	local AssemblyGunPartsObjectShadow =  CurGunPartsAssemblyFull.transform:Find("Shadow"):Find(data.code).gameObject
	if AssemblyGunPartsObjectShadow.activeSelf then
		AssemblyGunPartsObjectShadow:SetActive(false)
		AssemblyGunPartsObjectShadow:SetActive(true)
	else
		AssemblyGunPartsObjectShadow:SetActive(true)
	end
	CurrentGunPartsAssemblyObject[#CurrentGunPartsAssemblyObject+1] = AssemblyGunPartsObject
	LastGunPartsAssemblyObject = CurrentGunPartsAssemblyObject[#CurrentGunPartsAssemblyObject]
	local director = CurGunPartsAssemblyFull:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
	local playable = CS.ResManager.GetObjectByPath("Animation/GunslingerGirl/"..data.code,".playable")
	if playable ~= nil then
		director.playableAsset = CS.ResManager.GetObjectByPath("Animation/GunslingerGirl/"..data.code,".playable")
		director.timeUpdateMode = CS.UnityEngine.Playables.DirectorUpdateMode.GameTime	
		reverseDirector = false
		director:Play()
	end
	waitAnimation = true
	waitAnimationCountdown = data.waitTime + 0.2
	--local tweenplays = AssemblyGunPartsObject:GetComponents(typeof(CS.TweenPlay))
	--for i=0,tweenplays.Length-1 do
	--	DoTweenPlay(tweenplays[i],AssemblyGunPartsObject,false)
	--end
end
function DoTweenFade(image)
	local tweener = CS.DG.Tweening.ShortcutExtensions46.DOFade(image,0,0.3)
	CS.DG.Tweening.TweenExtensions.Play(tweener)
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
		CS.DG.Tweening.TweenSettingsExtensions.SetEase(tweener,(tweenplay.easeType))
		CS.DG.Tweening.TweenSettingsExtensions.SetDelay(tweener,tweenplay.delay)
		CS.DG.Tweening.TweenSettingsExtensions.SetLoops(tweener,tweenplay.loopTime,tweenplay.loopType)
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		CS.DG.Tweening.TweenExtensions.Play(tweener)
	end
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.PositionYLocal then
		local value = tweenplay.toOne
		if isreverse then 
			value = tweenplay.fromOne
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions.DOLocalMoveY
		(gameobject.transform,value,tweenplay.duration)
		CS.DG.Tweening.TweenSettingsExtensions.SetEase(tweener,(tweenplay.easeType))
		CS.DG.Tweening.TweenSettingsExtensions.SetDelay(tweener,tweenplay.delay)
		CS.DG.Tweening.TweenSettingsExtensions.SetDelay(tweener,tweenplay.delay)
		CS.DG.Tweening.TweenSettingsExtensions.SetLoops(tweener,tweenplay.loopTime,tweenplay.loopType)
	
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		CS.DG.Tweening.TweenExtensions.Play(tweener)
	end
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.PositionLocal then
		local value = tweenplay.toThree
		if isreverse then 
			value = tweenplay.fromThree
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions46.DOAnchorPos3D
		(gameobject:GetComponent(typeof(CS.UnityEngine.RectTransform)),tweenplay.toThree,tweenplay.duration)
		CS.DG.Tweening.TweenSettingsExtensions.SetEase(tweener,(tweenplay.easeType))
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		CS.DG.Tweening.TweenExtensions.Play(tweener)
	end
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.Rotation then
		local value = tweenplay.toThree
		if isreverse then 
			value = tweenplay.fromThree
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions.DORotate
		(gameobject.transform,tweenplay.toThree,tweenplay.duration,CS.DG.Tweening.RotateMode.WorldAxisAdd)
		CS.DG.Tweening.TweenSettingsExtensions.SetEase(tweener,(tweenplay.easeType))
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		CS.DG.Tweening.TweenExtensions.Play(tweener)
	end
	if tweenplay.currentTweenMode == CS.TweenPlay.TweenMode.Scale then
		local value = tweenplay.toThree
		if isreverse then 
			value = tweenplay.fromThree
		end
		local tweener = CS.DG.Tweening.ShortcutExtensions.DOScale
		(gameobject.transform,tweenplay.toThree,tweenplay.duration)
		CS.DG.Tweening.TweenSettingsExtensions.SetEase(tweener,(tweenplay.easeType))
		--CS.DG.Tweening.TweenSettingsExtensions.SetUpdate(tweener,true)
		CS.DG.Tweening.TweenExtensions.Play(tweener)
	end
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
		
		btnReset.gameObject:SetActive(false)
		btnUndo.gameObject:SetActive(false)
		btnBack.gameObject:SetActive(false)
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
		successMat = ImgSuccess:GetComponent(typeof(CS.ExImage)).material
		successMatChange = true

	end
end
function ReturnLastGunParts()	
	for i=1,#CurrentGunPartsID do
		if CurrentGunPartsID[i] == lastGunPartsID then
			GunPartShowStep(CurrentGunPartsObject[i],0)
			break
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
	local director = CurGunPartsAssemblyFull:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
	local playable = CS.ResManager.GetObjectByPath("Animation/GunslingerGirl/"..data.code,".playable")
	if playable ~= nil then
		director.playableAsset = CS.ResManager.GetObjectByPath("Animation/GunslingerGirl/"..data.code,".playable")
		director.timeUpdateMode = CS.UnityEngine.Playables.DirectorUpdateMode.Manual
		director.time = director.playableAsset.duration
		reverseDirector = true
		tempDirector = director
	end
	table.remove(CurrentGunPartsAssemblyObject)

	LastGunPartsAssemblyObject = CurrentGunPartsAssemblyObject[#CurrentGunPartsAssemblyObject]
	waitAnimation = true
	waitAnimationCountdown = data.waitTime + 0.2
	table.remove(AssemblyGunPartsIDList)
	if #AssemblyGunPartsIDList > 0 then
		lastGunPartsID =AssemblyGunPartsIDList[#AssemblyGunPartsIDList]
	end
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
			if countdown > GunAssemblyData[i].time then
				countdown = GunAssemblyData[i].time
			end
			TextGunName:GetComponent(typeof(CS.ExText)).text = tostring(GunAssemblyData[i].Name)
			TextGunslingerName:GetComponent(typeof(CS.ExText)).text = tostring(GunAssemblyData[i].GirlName)
			if GunAssemblyData[i].Name == "SVD" then
				ImgPreview = ImgPreviewSVD
			end	
			if GunAssemblyData[i].Name == "M249" then
				ImgPreview = ImgPreviewM249
			end	
			if GunAssemblyData[i].Name == "M1897" then
				ImgPreview = ImgPreviewM1897
			end	
			if GunAssemblyData[i].Name == "AUG" then
				ImgPreview = ImgPreviewAUG
			end	
			if GunAssemblyData[i].Name == "P90" then
				ImgPreview = ImgPreviewP90
			end	
			local arrmat = CS.UnityEngine.Material(CS.UnityEngine.Shader.Find("Unlit/UGUITexComplex"))
			ImgPreview:GetComponent(typeof(CS.ExImage)).material = arrmat
			ImgPreview:SetActive(true)
			local Tweens = ImgPreview:GetComponents(typeof(CS.TweenPlay))
			DoTweenPlay(Tweens[0],ImgPreview)
			DoTweenPlay(Tweens[1],ImgPreview)

			break
		end
	end
	if GunAssemblyAbleCount == 0 then
		CS.CommonController.MessageBox("零件不够",function()
				EndAssembly()
			end)
	end
end
function ShowGunParts()
	for i=1,#CurrentGunPartsID do
		local data = GetGunPartsDataById(CurrentGunPartsID[i])		
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
