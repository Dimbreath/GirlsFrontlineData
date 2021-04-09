local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
xlua.private_accessible(CS.CommonController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.BattleManualSkillController)
xlua.private_accessible(CS.BattleMemberController)
xlua.private_accessible(CS.BattleFieldTeamHolder)
xlua.private_accessible(CS.GF.Battle.BattleController)
xlua.private_accessible(CS.GF.Battle.BattleStatistics)
xlua.private_accessible(CS.BattleUIPauseController)
local SkillTable = {}
local mCurSelectedSkill ={}
local mCurSelectSkillPool ={}
local mCurSelectCardSkill ={}
local mCurSkill ={}
local TableStruct = nil
local character = nil
--当前波次
local currentWave = 0
local currentPerkType = 0
local isShowingSelect = false

local listBTSkillCfg = CS.GameData.listBTSkillCfg
local GoSkillCard1,GoSkillCard2,GoSkillCard3,GoSkillCard4
local selectedCardID = -1 

local NextWaveBuffSkillID = 90325501
local NextWaveBuffSkill = nil
local NextWaveBuffID = 7300
local waveAnimTime = 2.5
local doingWaveAnim = false
local waveAnimTimeCount = 0
local TextCountdown
local BattleController
local isCountingTime = false
local needShowPause = true
local countdownTimer
local BattleUIPauseController
local isSelected = false
InitSkill1 = function(SkillLabel,mCurSkill,pos)
	local skillLabelController
	skillLabelController = SkillLabel:GetComponent(typeof(CS.BattleManualSkillController))
	--注册技能和人物
	skillLabelController.mCurChar = character
	skillLabelController.mCurSkill = mCurSkill
	--初始化
	if pos == 1 then
		skillLabelController.imgBgActive.sprite = skillLabelController.arrSprBg[0]
		skillLabelController.imgBgActive.transform.localScale = CS.UnityEngine.Vector3(-1, 1, 1)
		skillLabelController.imgBgDisable.sprite = skillLabelController.arrSprBg[0]
		skillLabelController.imgBgDisable.transform.localScale = CS.UnityEngine.Vector3(-1, 1, 1)
		skillLabelController.imgBgPassive.sprite = skillLabelController.arrSprBg[0]
		skillLabelController.imgBgPassive.transform.localScale = CS.UnityEngine.Vector3(-1, 1, 1)
		skillLabelController.imageHintBg.transform.localScale = CS.UnityEngine.Vector3(-1, 1, 1)
	end
	if pos == 2 or pos == 3 then
		skillLabelController.imgBgActive.sprite = skillLabelController.arrSprBg[1]
		skillLabelController.imgBgActive.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
		skillLabelController.imgBgDisable.sprite = skillLabelController.arrSprBg[1]
		skillLabelController.imgBgDisable.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
		skillLabelController.imgBgPassive.sprite = skillLabelController.arrSprBg[1]
		skillLabelController.imgBgPassive.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
		skillLabelController.imageHintBg.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
	end
	if pos == 4 then
		skillLabelController.imgBgActive.sprite = skillLabelController.arrSprBg[0]
		skillLabelController.imgBgActive.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
		skillLabelController.imgBgDisable.sprite = skillLabelController.arrSprBg[0]
		skillLabelController.imgBgDisable.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
		skillLabelController.imgBgPassive.sprite = skillLabelController.arrSprBg[0]
		skillLabelController.imgBgPassive.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
		skillLabelController.imageHintBg.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
	end
	skillLabelController.imageRank.sprite = skillLabelController.spriteRarity[character.gun.info.rank]
	skillLabelController.imageIcon.enabled = false
	skillLabelController.imageIcon:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta = CS.UnityEngine.Vector2(120, 120)
	skillLabelController.imageIcon:GetComponent(typeof(CS.UnityEngine.UI.RectMask2D)).enabled = true
	local pic = CS.CommonController.LoadSmallPic(character.gun, skillLabelController.imageIcon.transform, CS.UnityEngine.Vector2.zero)
	if pic ~= nil then
		pic:ShowTuJian(nil, 0.4, 0.6)
		local transPic = pic:GetComponent(typeof(CS.UnityEngine.RectTransform))
		transPic.localScale = CS.UnityEngine.Vector3(0.75, 0.3, 1)
		transPic.anchoredPosition = CS.UnityEngine.Vector2(0, 18)
	end
	skillLabelController.imageIcon.gameObject:SetActive(true)
	skillLabelController.goSkill2Perf:SetActive(false)
	skillLabelController.animCDDone.gameObject:SetActive(false)
	skillLabelController.animActive.gameObject:SetActive(false)
	skillLabelController.imageHintBg.gameObject:SetActive(false)
	if mCurSkill ~= nil then
		--print("-----------"..pos)
		local skillIcon = CS.CommonController.InstantiateSkillIcon(mCurSkill.info:GetIconCodeBySkin(character.gun.currentSkinId))
		local rectIcon = skillIcon:GetComponent(typeof(CS.UnityEngine.RectTransform))
		rectIcon:SetParent(skillLabelController.objSkill.transform,false)
		rectIcon:SetSiblingIndex(0)
		rectIcon:SetSizeWithCurrentAnchors(CS.UnityEngine.RectTransform.Axis.Horizontal, 100)
		rectIcon:SetSizeWithCurrentAnchors(CS.UnityEngine.RectTransform.Axis.Vertical, 100)
	end
	skillLabelController:_Active(true)
end

--Awake：初始化数据
Awake = function()	
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
	SkillTable = CS.GameData.listRoguelikeMinigameData
	TextCountdown = TextTime:GetComponent(typeof(CS.ExText))
	BattleController = CS.GF.Battle.BattleController.Instance
	BattleUIPauseController = CS.BattleUIPauseController.Instance
	--使得人物不前进
	local TriggerAdvanceEvent = function(self)
		return
	end
	util.hotfix_ex(CS.GF.Battle.BattleController,'TriggerAdvanceEvent',TriggerAdvanceEvent)
end

--Start: 加载组件
Start = function()
	local suretxt = self.transform:Find("PickCard/Btn_Confirm/UI_Text"):GetComponent(typeof(CS.ExText));
	suretxt.text = CS.Data.GetLang(260036);
	--禁止人物拖动并锁定镜头
	--CS.BattleInteractionController.isGuideInteractable = false
	--CS.BattleInteractionController.isGuideCanNotScale = false
	--CS.BattleInteractionController.isGuideCanNotOffset = false
	CS.GF.Battle.SkillUtils.AutoSkill = false	
	CS.GF.Battle.BattleController.Instance.resetAutoSkill = true
	--CS.GF.Battle.BattleController.Instance.resetCameraLock = true

	--注册相机
	self.transform:SetParent(CS.BattleUIController.Instance.transform:Find('UI'),false)
	--self:GetComponent('Canvas').worldCamera = CS.UnityEngine.Camera.main
	--注册人物
	if character == nil then
		character = CS.BattleLuaUtility.GetCharacterByCode('Rogue_D')
	end
	--停止移动
	CS.GF.Battle.BattleController.Instance:TriggerStopEvent()
	
	--注册人物技能
	mCurSkill[0] = character.gun:GetSkillByGroupId(903201)
	mCurSkill[1] = character.gun:GetSkillByGroupId(903301)
	NextWaveBuffSkill = CS.GameData.listBTSkillCfg:GetDataById(NextWaveBuffSkillID)
	local charPos = character.transform
	character:SetMemberAnimation("wait", 1)
	CS.BattleUIManualSkillController.Instance.gameObject:SetActive(false)
	CS.BattleUIController.Instance.btnDPSSwitch.gameObject:SetActive(false)
	if CS.BattleDPSController.Instance ~= nil then
		CS.BattleDPSController.Instance.gameObject:SetActive(false)
	end
	--CS.BattleLuaUtility.SwitchUIManualPannel(false) -- 关闭手动技能面板
	
	InitSkill1(SkillLabel1,mCurSkill[0],1)
	InitSkill1(SkillLabel2,mCurSkill[1],4)
	--InitSkill1(SkillLabel3,mCurSkill[2],2)
	--InitSkill1(SkillLabel4,mCurSkill[3],4)	
	--人物立绘
	if character ~= nil then
		CS.CommonController.LoadBigPic(character.gun,GoTimeStop.transform:Find("PicHolder"))
	end
	BtnPickCardConfirm:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
			if not isSelected then 
				return
			end
			local skillInfo = SkillTable[selectedCardID]
			--选择技能：将技能添加进选择列表
			mCurSelectedSkill[#mCurSelectedSkill + 1] = selectedCardID
			--给角色添加对应的技能
			character.gun:AddDynamicPassiveInstantSkill(skillInfo.skill_id)
			if skillInfo.rank_c == 1 then
				currentPerkType = skillInfo.ListSkillType[0]
			end
			--给Clock上的标识染色
					
			if #mCurSelectedSkill >= 8 then
				ColorClock(253,132,1)
			else
				if #mCurSelectedSkill >= 6 then
					ColorClock(255,176,0)
				else
					if #mCurSelectedSkill >= 2 then
						ColorClock(189,209,62)
					else
						ColorClock(211,207,206)
					end	
				end
			end	
			
			--暂停界面对应标签
			local battleSkillCfg = listBTSkillCfg:GetDataById((skillInfo.skill_id * 100) + 1)
			SkillCardName:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.name
			SkillCardDes:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.description
			SkillCardRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[skillInfo.rank_c-1]
			if battleSkillCfg.rank_c == 4 then
				SkillCardTextRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardTextRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[1]
			end
			GoSkillCard.transform:Find("OnSelect").gameObject:SetActive(false)
			local gunCode = skillInfo.gunCode
			local goSkillCard = CS.UnityEngine.Object.Instantiate(GoSkillCard)
			if #mCurSelectedSkill > 4 then
				goSkillCard.transform:SetParent(GoTimeStop.transform:Find("SkillHolder/SkillLayout2"),false)
			else
				goSkillCard.transform:SetParent(GoTimeStop.transform:Find("SkillHolder/SkillLayout1"),false)
			end
			goSkillCard.gameObject:SetActive(true)

			CS.CommonController.LoadSmallPicAsync(skillInfo.code,goSkillCard.transform:Find("Msg/GunHolder/Img_gun"),0,function(obj,errorMsg,userData)
					local picController = obj:GetComponent(typeof(CS.CommonPicController))
					picController:SwitchDamaged(false)
				end)
			EndSelect()
			
		end)
	BtnPauseResolveBattle:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function ()
		ShowSettlementFromPause()
	end)
	isCountingTime = true
	BtnCloseSettlement:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function ()
		EndSettlement()
	end)
	BtnContinue:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function ()
		BattleUIPauseController:OnClickPause()
	end)
	BtnEndless:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function ()
		BattleUIPauseController:OnClickPause()
	end)
	BtnStopSwitch:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function ()
		SwitchTimeStopShowSkill()	
	end)
end

Update = function()
	--检测是否需要显示界面
	if CheckNextWave() and not isShowingSelect then
		isShowingSelect = true
		ShowSelect()
	end
	if doingWaveAnim then
		waveAnimTimeCount = waveAnimTimeCount + CS.UnityEngine.Time.deltaTime
		if waveAnimTimeCount >= waveAnimTime then
			HideWave()
		end
	end
	if isCountingTime then
		countdownTimer = BattleController.CurBattleTime
		local countdownMinute = math.modf(countdownTimer / 60)
		local countdownSec = math.modf(countdownTimer - countdownMinute * 60) 
		TextCountdown.text = string.format("%02d",(countdownMinute))..":"..string.format("%02d",(countdownSec))
	end
	if BattleController.isPause and needShowPause and CS.AVGController.inst == nil then
		ShowTimeStop()
		HideWave()
	else
		HideTimeStop()
	end
	if character:IsDead() or character.status == CS.GF.Battle.CharacterStatus.withdraw then
		ShowSettlementFromDie()
	end
end

function ShowSelect()
	currentWave = currentWave + 1
	--按照波次生成随机卡池 第1波稀有度为1 2-5波稀有度是2 6-7波稀有度是3 8波稀有度是4.之后不再选择 每次随机选择4个
	if currentWave <= 8 then
		
		--暂停游戏
		CS.BattleFrameManager.StopTime(true,99999)
		isCountingTime = false
		isSelected = false
		GenSkillPool()
		DestroyChildren(TransPickCardHolder.transform)
		GoPickCard:SetActive(true)
		--显示4个牌
		print("selcard  "..mCurSelectCardSkill[1].." "..mCurSelectCardSkill[2].." "..mCurSelectCardSkill[3].." "..mCurSelectCardSkill[4])
		local skillID = mCurSelectCardSkill[1]
		local skillInfo = SkillTable[skillID]
		local battleSkillCfg = listBTSkillCfg:GetDataById((skillInfo.skill_id * 100) + 1)
		SkillCardName:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.name
		SkillCardDes:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.description
		SkillCardRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[skillInfo.rank_c-1]
		if battleSkillCfg.rank_c == 4 then
			SkillCardTextRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardTextRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[1]
		end
		GoSkillCard.transform:Find("OnSelect").gameObject:SetActive(false)
		local gunCode = skillInfo.gunCode
		GoSkillCard1 = CS.UnityEngine.Object.Instantiate(GoSkillCard)
		GoSkillCard1.transform:SetParent(TransPickCardHolder.transform,false)
		GoSkillCard1.gameObject:SetActive(true)
		GoSkillCard1:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
				selectedCardID = mCurSelectCardSkill[1]	
				UpdateSelectState()
			end)
		CS.CommonController.LoadSmallPicAsync(skillInfo.code,GoSkillCard1.transform:Find("Msg/GunHolder/Img_gun"),0,function(obj,errorMsg,userData)
				local picController = obj:GetComponent(typeof(CS.CommonPicController))
				picController:SwitchDamaged(false)
			end)
		
		skillID = mCurSelectCardSkill[2]
		skillInfo = SkillTable[skillID]
		battleSkillCfg = listBTSkillCfg:GetDataById((skillInfo.skill_id * 100) + 1)
		SkillCardName:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.name
		SkillCardDes:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.description
		SkillCardRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[skillInfo.rank_c-1]
		if battleSkillCfg.rank_c == 4 then
			SkillCardTextRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardTextRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[1]
		end
		GoSkillCard2 = CS.UnityEngine.Object.Instantiate(GoSkillCard)
		GoSkillCard2.transform:SetParent(TransPickCardHolder.transform,false)
		GoSkillCard2.gameObject:SetActive(true)
		GoSkillCard2:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
				selectedCardID = mCurSelectCardSkill[2]	
				UpdateSelectState()
			end)
		CS.CommonController.LoadSmallPicAsync(skillInfo.code,GoSkillCard2.transform:Find("Msg/GunHolder/Img_gun"),0,function(obj,errorMsg,userData)
				local picController = obj:GetComponent(typeof(CS.CommonPicController))
				picController:SwitchDamaged(false)
			end)
		
		skillID = mCurSelectCardSkill[3]
		skillInfo = SkillTable[skillID]
		battleSkillCfg = listBTSkillCfg:GetDataById((skillInfo.skill_id * 100) + 1)
		SkillCardName:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.name
		SkillCardDes:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.description
		SkillCardRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[skillInfo.rank_c-1]
		if battleSkillCfg.rank_c == 4 then
			SkillCardTextRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardTextRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[1]
		end
		GoSkillCard3 = CS.UnityEngine.Object.Instantiate(GoSkillCard)
		GoSkillCard3.transform:SetParent(TransPickCardHolder.transform,false)
		GoSkillCard3.gameObject:SetActive(true)
		GoSkillCard3:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
				selectedCardID = mCurSelectCardSkill[3]	
				UpdateSelectState()
			end)
		CS.CommonController.LoadSmallPicAsync(skillInfo.code,GoSkillCard3.transform:Find("Msg/GunHolder/Img_gun"),0,function(obj,errorMsg,userData)
				local picController = obj:GetComponent(typeof(CS.CommonPicController))
				picController:SwitchDamaged(false)
			end)
		
		skillID = mCurSelectCardSkill[4]
		skillInfo = SkillTable[skillID]
		battleSkillCfg = listBTSkillCfg:GetDataById((skillInfo.skill_id * 100) + 1)
		SkillCardName:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.name
		SkillCardDes:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.description	
		SkillCardRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[skillInfo.rank_c-1]
		if battleSkillCfg.rank_c == 4 then
			SkillCardTextRank:GetComponent(typeof(CS.ExImage)).sprite = SkillCardTextRank:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[1]
		end
		GoSkillCard4 = CS.UnityEngine.Object.Instantiate(GoSkillCard)
		GoSkillCard4.transform:SetParent(TransPickCardHolder.transform,false)
		GoSkillCard4.gameObject:SetActive(true)
		GoSkillCard4:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
				selectedCardID = mCurSelectCardSkill[4]	
				UpdateSelectState()
			end)
		CS.CommonController.LoadSmallPicAsync(skillInfo.code,GoSkillCard4.transform:Find("Msg/GunHolder/Img_gun"),0,function(obj,errorMsg,userData)
				local picController = obj:GetComponent(typeof(CS.CommonPicController))
				picController:SwitchDamaged(false)
			end)
	else
		EndSelect()
	end
end

function UpdateSelectState()
	isSelected = true
	GoSkillCard1.transform:Find("OnSelect").gameObject:SetActive(selectedCardID == mCurSelectCardSkill[1])
	GoSkillCard2.transform:Find("OnSelect").gameObject:SetActive(selectedCardID == mCurSelectCardSkill[2])
	GoSkillCard3.transform:Find("OnSelect").gameObject:SetActive(selectedCardID == mCurSelectCardSkill[3])
	GoSkillCard4.transform:Find("OnSelect").gameObject:SetActive(selectedCardID == mCurSelectCardSkill[4])
end
--关闭选择界面 删除buff
function EndSelect()
	--消除角色上的对应buff
	CS.GF.Battle.SkillUtils.GenBuff(
		CS.GF.Battle.BattleSkillCfgEx(NextWaveBuffSkill, false, nil, nil),
		character.listMember[0],
		NextWaveBuffSkill.buffTarget,
		{-1},
		0
	)
	isShowingSelect = false
	--关闭界面
	GoPickCard:SetActive(false)
	--解除游戏暂停
	CS.BattleFrameManager.ResumeTime()
	--波次显示
	ShowWave()
	isCountingTime = true
	--显示无尽模式
	if currentWave == 9 or currentWave == 21  then		
		ShowTimeStopEndWave()
		if not BattleController.isPause and needShowPause then
			BattleUIPauseController:OnClickPause()
		end
	end
end
function GenSkillPool()
	print(currentWave)
	local poolRarity = 1
	if currentWave >= 2 then
		poolRarity = 2
	end
	if currentWave >= 6 then
		poolRarity = 3
	end
	if currentWave >= 8 then
		poolRarity = 4
	end
	mCurSelectSkillPool = {}
	--将符合要求的加入总技能池
	for i=0, SkillTable.Count - 1 do
		if SkillTable[i].rank_c == poolRarity and IsPerkType(SkillTable[i]) and (not IsInSkillList(SkillTable[i].id - 1)) then
			mCurSelectSkillPool[# mCurSelectSkillPool + 1] = SkillTable[i].id - 1
		end
	end
	print(#mCurSelectSkillPool)
	--从技能池里随机选择4个不重复的技能 作为卡片技能
	local randList = GetRandomList(#mCurSelectSkillPool , 4)
	mCurSelectCardSkill[1] = mCurSelectSkillPool[randList[1]]
	mCurSelectCardSkill[2] = mCurSelectSkillPool[randList[2]]
	mCurSelectCardSkill[3] = mCurSelectSkillPool[randList[3]]
	mCurSelectCardSkill[4] = mCurSelectSkillPool[randList[4]]
end
function CheckNextWave()
	if character:IsDead() or character.status == CS.GF.Battle.CharacterStatus.withdraw then
		return false
	end
	local BuffTier = character.conditionListSelf:GetTierByID(NextWaveBuffID)
	return (BuffTier > 0)
end
function PlaySFX(FXname)
	if FXname == "perfectClear" then
		CS.CommonAudioController.PlayUI("UI_clear_perfect")
	end
end
function GetName(NameID)
	return CS.Data.GetLang((NameID))
end
function IsPerkType(value)
	if currentPerkType == 0 then
		return true
	else
		for i=0, value.ListSkillType.Count -1 do
			if value.ListSkillType[i] == currentPerkType then
				return true
			end
		end
		return false
	end
	
	
end
function IsInSkillList(value)
	for i=1, #mCurSelectedSkill do
		print("IsInSkillList "..value..' '..mCurSelectedSkill[i])
		if value == mCurSelectedSkill[i] then
			return true
		end		
	end
	return false
end
function IsInTable(value, table)
	for k,v in ipairs(table) do
  		if v == value then
  			return true
  		end
	end
	return false
end
function GetRandomList(total, req)
	local randList = {}
	if total <= req then
		for i=1, req do
			randList[#randList + 1] = i
		end
	else
		for i=1, req do
			local num = math.random(1,total)
			local cnt = 0
			while IsInTable(num,randList) and cnt <= 1000 do
				num = math.random(1,total)
				cnt = cnt + 1
			end
			randList[#randList + 1] = num
		end
	end	
	return randList
end
function DestroyChildren(transform)
	for i=0,transform.childCount-1 do
		CS.UnityEngine.Object.Destroy(transform:GetChild(i).gameObject)
	end
	return 
end
function ShowWave()
	GoEnemyWave:SetActive(true)
	TextEnemyWave:GetComponent(typeof(CS.ExText)).text = string.gsub(GetName(60112),"{0}",tostring(currentWave))
	doingWaveAnim = true
	waveAnimTimeCount = 0
end
function HideWave()
	GoEnemyWave:SetActive(false)
	doingWaveAnim = false
end
function ShowTimeStop()
	if not GoTimeStop.activeSelf and not GoPickCard.activeSelf then
		GoTimeStop:SetActive(true)
		BattleUIPauseController.transform:Find("InPause/ButtonWithdraw").gameObject:SetActive(false)
		BattleUIPauseController.transform:Find("InPause/ImageInPause").gameObject:SetActive(false)
		BattleUIPauseController.btnCollection.gameObject:SetActive(false)
		if #mCurSelectedSkill > 4 then
			BtnStopSwitch:SetActive(true)
		else
			BtnStopSwitch:SetActive(false)
		end
		BtnContinue.gameObject:SetActive(true)
		BtnEndless.gameObject:SetActive(false)
		if character ~= nil then
			local life = math.floor(character.gun.life)
			local maxlife = math.floor(character.gun.maxLife)
			local percent = life/maxlife
			GoTimeStop.transform:Find("LifeBar/Tex_LifeDetail").gameObject:GetComponent(typeof(CS.ExText)).text = string.gsub(string.gsub(GetName(60119),"{0}",tostring(life)),"{1}",tostring(maxlife))
			GoTimeStop.transform:Find("LifeBar/Img_LifeBar").gameObject:GetComponent(typeof(CS.ExImage)).fillAmount = percent
		end
	end
end
function ShowTimeStopEndWave()
	GoTimeStop:SetActive(true)

	BattleUIPauseController.transform:Find("InPause/ButtonWithdraw").gameObject:SetActive(false)
	BattleUIPauseController.btnCollection.gameObject:SetActive(false)
	BattleUIPauseController.transform:Find("InPause/ImageInPause").gameObject:SetActive(false)
	BattleUIPauseController.transform:Find("PauseButton").gameObject:SetActive(false)
	BtnContinue.gameObject:SetActive(false)
	BtnEndless.gameObject:SetActive(true)
	BtnStopSwitch:SetActive(true)
	if character ~= nil then
		local life = math.floor(character.gun.life)
		local maxlife = math.floor(character.gun.maxLife)
		local percent = life/maxlife
		GoTimeStop.transform:Find("LifeBar/Tex_LifeDetail").gameObject:GetComponent(typeof(CS.ExText)).text = string.gsub(string.gsub(GetName(60119),"{0}",tostring(life)),"{1}",tostring(maxlife))
		GoTimeStop.transform:Find("LifeBar/Img_LifeBar").gameObject:GetComponent(typeof(CS.ExImage)).fillAmount = percent
	end
end
function HideTimeStop()
	if GoTimeStop.activeSelf then
		GoTimeStop:SetActive(false)
		BattleUIPauseController.transform:Find("InPause/ImageInPause").gameObject:SetActive(true)
		BattleUIPauseController.transform:Find("PauseButton").gameObject:SetActive(true)
	end
end
function ShowSettlementFromPause()
	needShowPause = false
	GoTimeStop:SetActive(false)
	BattleUIPauseController:OnClickPause()
	ShowSettlement()
end
local SettlementLose = false
function ShowSettlementFromDie()
	if GoSettlement.activeSelf then
		return
	end
	--SettlementLose = true
	ShowSettlement()
end
function ShowSettlement()
	GoSettlement:SetActive(true)
	CS.BattleFrameManager.StopTime(true,99999)
	isCountingTime = false
	TextSettlementTitle:GetComponent(typeof(CS.ExText)).text = string.gsub(GetName(60128),"{0}",tostring(currentWave))
	--玩家信息
	if CS.GameData.userInfo ~= nil then
		TextResultName:GetComponent(typeof(CS.ExText)).text = CS.GameData.userInfo.name
		TextResultID:GetComponent(typeof(CS.ExText)).text ="UID:"..CS.GameData.userInfo.userId
		TextResultLevel:GetComponent(typeof(CS.ExText)).text ="Lv."..CS.GameData.userInfo.level
	end
	local countdownMinute = math.modf(countdownTimer / 60)
	local countdownSec = math.modf(countdownTimer - countdownMinute * 60) 
	TextResultTime:GetComponent(typeof(CS.ExText)).text = string.format("%02d",(countdownMinute))..":"..string.format("%02d",(countdownSec))
	--技能信息
	for i=1, #mCurSelectedSkill do
		local skillid = mCurSelectedSkill[i]
		local skillInfo = SkillTable[skillid]
		local battleSkillCfg = listBTSkillCfg:GetDataById((skillInfo.skill_id * 100) + 1)
		
		local settlementSkillObj = CS.UnityEngine.Object.Instantiate(GoSkillCardSettlement)
		if i <= 4 then
			settlementSkillObj.transform:SetParent(GoSettlement.transform:Find("CardLayoutU"),false)
		else
			settlementSkillObj.transform:SetParent(GoSettlement.transform:Find("CardLayoutD"),false)
		end

		settlementSkillObj.transform:Find("Tex_Name").gameObject:GetComponent(typeof(CS.ExText)).text = battleSkillCfg.name
		CS.CommonController.LoadSmallPicAsync(skillInfo.code,settlementSkillObj.transform:Find("GunHolder"),0,function(obj,errorMsg,userData)
				if obj ~= nil then
					local picController = obj:GetComponent(typeof(CS.CommonPicController))
					picController:SwitchDamaged(false)
					local sprite = settlementSkillObj:GetComponent(typeof(CS.UGUISpriteHolder)).listSprite[0]
					local tex = sprite.texture
					picController.ArrMat:SetTexture("_AlphaTex", tex)
					picController.transform.localScale = CS.UnityEngine.Vector3(0.905,0.905,1)
				end
			end)
		settlementSkillObj:SetActive(true)
	end
	--角色生命
	if character ~= nil then
		local life = math.floor(character.gun.life)
		local maxlife = math.floor(character.gun.maxLife)
		local percent = life/maxlife
		GoSettlement.transform:Find("LifeBar/Tex_LifeDetail").gameObject:GetComponent(typeof(CS.ExText)).text = string.gsub(string.gsub(GetName(60119),"{0}",tostring(life)),"{1}",tostring(maxlife))
		GoSettlement.transform:Find("LifeBar/Img_LifeBar").gameObject:GetComponent(typeof(CS.ExImage)).fillAmount = percent
	end
	--人物立绘
	if character ~= nil then
		CS.CommonController.LoadBigPic(character.gun,GoSettlement.transform:Find("PicHolder"))
	end
end
function EndSettlement()
	--if SettlementLose then
	--	CS.BattleFrameManager.ResumeTime()
	--	BattleController:TriggerBattleFinishEvent(true)
	--else
	local enemyList = {}
	for k,v in pairs(BattleController.enemyTeamHolder:GetCharacters()) do
		local DamageInfo = CS.GF.Battle.BattleDamageInfo()
		enemyList[#enemyList+1] = v
	end
	for i = 1, #enemyList do
		enemyList[i]:UpdateLife(DamageInfo, -999999)
	end
	CS.BattleFrameManager.ResumeTime()
	BattleController:TriggerBattleFinishEvent()
	CS.UnityEngine.Object.Destroy(self.gameObject)
	--end
	
end
function SwitchTimeStopShowSkill()
	local goTimeStopSkillHolder1 = GoTimeStop.transform:Find("SkillHolder/SkillLayout1").gameObject
	local goTimeStopSkillHolder2 = GoTimeStop.transform:Find("SkillHolder/SkillLayout2").gameObject
	if goTimeStopSkillHolder2.activeSelf then
		goTimeStopSkillHolder2:SetActive(false)
		goTimeStopSkillHolder1:SetActive(true)
	else
		goTimeStopSkillHolder2:SetActive(true)
		goTimeStopSkillHolder1:SetActive(false)
	end
end
function ColorClock(r,g,b)
	ClockCardStatus.transform:GetChild(#mCurSelectedSkill - 1).gameObject:GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(r/255,g/255,b/255,1)
end
--depose
OnDestroy =function()
	character = nil
	mCurSkill ={}
	xlua.hotfix(CS.GF.Battle.BattleController,'TriggerAdvanceEvent',nil)
end

