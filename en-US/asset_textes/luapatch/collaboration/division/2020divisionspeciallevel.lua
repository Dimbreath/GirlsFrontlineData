local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
xlua.private_accessible(CS.CommonController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.BattleManualSkillController)
xlua.private_accessible(CS.BattleObstacleController)
xlua.private_accessible(CS.GF.Battle.BattleController)
xlua.private_accessible(CS.BattleFieldTeamHolder)

local character = nil
local mCurSkill ={}
local maxX = 7
local minX = -8
local maxY = 2.1
local minY = -7.1
local txCD = nil
--X分量的系数
local speedXPara = 0.02
--Y分量的系数
local speedYPara = 0.02
--后撤移动时的额外系数
local XBackMovePara = 1
local moveFowardID = 40540701
local moveBackID = 40540801
local cfgMoveFoward = nil
local cfgMoveBack = nil
local isMoving = false
local thisFrameJoyStick = false
local timecount = 0
local textTime
local CountTime = true
local buffskillid = 90108601
local isHK416 = false
local winFunctionFlag = false
local WinBuffID = 7124
local SkillBuffID = 712503

local isCountingTime = false
local countdownTimer = 0
local isWaitForEndAnim = false
local WaitForEndAnimTimer = 0
local EndAnimWaitTime = 5
local isMovingAnim = false
local isMovingForwardAnim =  true
local BattleController
local TextCountdown
local TweenplaySkill1On
local TweenplaySkill1Off
local RankSpriteHolder
local ExtraTime = 0
local eachExtra = 25
SkillActive = function(active,showCD)
	
end
InitSkill1 = function(SkillLabel,mCurSkill,pos)
	local skillLabelController
	skillLabelController = SkillLabel:GetComponent(typeof(CS.BattleManualSkillController))
	--注册技能和人物
	skillLabelController.mCurChar = character
	skillLabelController.mCurSkill = mCurSkill
	--skillLabelController.SkillType = pos
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
	if pos == 2 then
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
	RankSpriteHolder = ImgRank:GetComponent(typeof(CS.UGUISpriteHolder))
	--CS.BattleUIManualSkillController.listManualSkillController:Add(SkillLabel)
end

JoyStickMove = function(input)
	if input.value >= 0.05 then
		if character ~= nil and isMovingAnim == false then		
			isMovingAnim = true	
			if input.eulerAngle >= math.pi then
				isMovingForwardAnim = true
				character:SetMemberAnimation("move", 1)
			else
				isMovingForwardAnim = false
				character:SetMemberAnimation("move", -1)
			end
		end
		if input.eulerAngle < math.pi then
			if isMovingForwardAnim then
				isMovingForwardAnim = false
				character:SetMemberAnimation("move", -1)
			end
		else
			if not isMovingForwardAnim then
				isMovingForwardAnim = true
				character:SetMemberAnimation("move", 1)
			end
		end
	else
		if isMovingAnim then
			isMovingAnim = false
			if character ~= nil then
				character:SetMemberAnimation("wait", 1)
			end
		end
	end
	--character:JoyStickMove(input)
	if input.value < 0 or character:IsDead() then
		return
	end
	local x = character:GetAxisX(input)
	local y = character:GetAxisY(input)
	local pos = CS.UnityEngine.Vector3(x,0,y)
	local posX = CS.UnityEngine.Vector3(x,0,0)
	local posY = CS.UnityEngine.Vector3(0,0,y)
	local offset = pos - character.transform.localPosition
	local offsetX = posX
	local offsetY = posY - character.transform.localPosition
	--print(pos:ToString())
	--print(offset:ToString())
	--print(offsetX:ToString())
	--print(offsetY:ToString())
	local tempPos = character.transform.position + offset
	local tempPosX = character.transform.position + offsetX
	local tempPosY = character.transform.position + offsetY
	--CS.UnityEngine.Debug.DrawRay(character.transform.position,offset,CS.UnityEngine.Color.red,10)
	--CS.UnityEngine.Debug.DrawRay(character.transform.position,offsetX,CS.UnityEngine.Color.cyan,10)
	--CS.UnityEngine.Debug.DrawRay(character.transform.position,offsetY,CS.UnityEngine.Color.green,10)
	if character:CheckCollision(tempPosX) then
		offsetX = CS.UnityEngine.Vector3(0,0,0)
	end
	if character:CheckCollision(tempPosY) then
		offsetY = CS.UnityEngine.Vector3(0,0,0)
	end
	--if character:CheckCollision(tempPos) then		
	--	offset = CS.UnityEngine.Vector3(0,0,0)
	--end
	character.moveOffset = character.transform.localPosition + offsetX + offsetY
	character.transform.localPosition = CS.UnityEngine.Vector3(0,0,character.moveOffset.z)
	--local posX = CS.UnityEngine.Vector3(x,0,0)
	--local posY = CS.UnityEngine.Vector3(0,0,y)

	--local tempPosX = character.transform.position + posX
	--local tempPosY = character.transform.position + posY
	
	--CS.UnityEngine.Debug.DrawRay(character.transform.position,offsetX,CS.UnityEngine.Color.red,10)
	--CS.UnityEngine.Debug.DrawRay(character.transform.position,offsetY,CS.UnityEngine.Color.yellow,10)
	
	--if not character:CheckCollision(tempPosX) then
	--	posX = CS.UnityEngine.Vector3(0,0,0)
	--end
	--if not character:CheckCollision(tempPosY) then
	--	posY = CS.UnityEngine.Vector3(0,0,0)
	--end




end

JoyStickBegin = function(input)
	
end

JoyStickEnd = function(input)
	
end

TriggerInvincible = function()
	
end

--Awake：初始化数据
Awake = function()
	-- 关闭自动释放技能
	local RefreshFriendlyTargetList = function(self)
		self.listFriendlyTarget:Clear()
		for i=0,self.enemyTeamHolder.listCharacter.Count -1 do
			local target = self.enemyTeamHolder.listCharacter[i]
			if not target.isPhased then
				self.listFriendlyTarget:Add(target)
			end
		end
		if self.listFriendlyTarget.Count == 0 then
			self:CheckFormation()
		end
	end
	util.hotfix_ex(CS.GF.Battle.BattleController,'RefreshFriendlyTargetList',RefreshFriendlyTargetList)
end

--Start: 加载组件
Start = function()
	--禁止人物拖动
	CS.BattleInteractionController.isGuideInteractable = false
	CS.BattleInteractionController.isGuideCanNotScale = false
	CS.BattleInteractionController.isGuideCanNotOffset = false
	CS.GF.Battle.SkillUtils.AutoSkill = false	
	CS.GF.Battle.BattleController.Instance.resetAutoSkill = true
	CS.GF.Battle.BattleController.Instance.resetCameraLock = true
	CS.GF.Battle.BattleController.Instance.transform:Find("BattleField/CameraPositionDynamic/CameraPositionStatic/Main Camera/ShiningDust").gameObject:SetActive(false)
	
	--注册相机
	self.transform:SetParent(CS.BattleUIController.Instance.transform:Find('UI'),false)
	--self:GetComponent('Canvas').worldCamera = CS.UnityEngine.Camera.main
	--注册人物
	if character == nil then
		character = CS.BattleLuaUtility.GetCharacterByCode('HK416Agent')
		isHK416 = true
	end
	if character == nil then
		isHK416 = false
		character = CS.BattleLuaUtility.GetCharacterByCode('VectorAgent')
	end	

	CS.BattleLuaUtility.SwitchUIManualPannel(false) -- 关闭手动技能面板
	BattleController = CS.GF.Battle.BattleController.Instance
	TextCountdown = TextTimeCount:GetComponent(typeof(CS.ExText)) 
	JoyStick:GetComponent(typeof(CS.Joystick)).JoystickMoveHandle = JoyStickMove
	JoyStick:GetComponent(typeof(CS.Joystick)).JoystickEndHandle = JoyStickEnd
	JoyStick:GetComponent(typeof(CS.Joystick)).JoystickBeginHandle = JoyStickBegin
	
	if isHK416 then
		mCurSkill[0] = character.gun:GetSkillByGroupId(901083)
		mCurSkill[1] = character.gun:GetSkillByGroupId(901082)
		mCurSkill[2] = character.gun:GetSkillByGroupId(901080)
	else 
		mCurSkill[0] = character.gun:GetSkillByGroupId(901084)
		mCurSkill[1] = character.gun:GetSkillByGroupId(901082)
		mCurSkill[2] = character.gun:GetSkillByGroupId(901081)
	end
	InitSkill1(Skill1,mCurSkill[0],3)
	InitSkill1(Skill2,mCurSkill[1],1)
	InitSkill1(Skill3,mCurSkill[2],2)
	local tweenplays = Skill1:GetComponents(typeof(CS.TweenPlay))
	TweenplaySkill1On = tweenplays[0]
	TweenplaySkill1Off = tweenplays[1]
	TweenplaySkill1Off.EndHandle = Skill1Off
	character:SetMemberAnimation("wait", 1)
	local GetAxisX = function(self,input)
		local t = 1
		if input.value <= 0.05 then t = 0 end
		local x = 
		CS.Mathf.Clamp(
			character.transform.localPosition.x - math.sin(input.eulerAngle) * character.realtimeSpeed * speedXPara * t,
			minX,
			maxX
		)
		return x
	end
	local GetAxisY = function(self,input)
		local t = 1
		if input.value <= 0.05 then t = 0 end
		local y =
		CS.Mathf.Clamp(
			character.transform.localPosition.z + math.cos(input.eulerAngle) * character.realtimeSpeed * speedYPara * t,
			minY,
			maxY
		)
		return y
	end
	local ShelterBuffOn = function(self)
		--print("ShelterBuffOn")
		local cfgbuff = CS.GameData.listBTSkillCfg:GetDataById(buffskillid)
		local buffcfg = CS.GameData.listBTBuffCfg:GetDataById(cfgbuff.buffSelf[0])
		self.tempCondition = CS.GF.Battle.CharacterCondition(CS.GF.Battle.BattleSkillCfgEx(cfgbuff,false,nil,nil),buffcfg)
		self.tempCondition.duration = 999999
		self.conditionListSelf:Add(self.tempCondition)
		self.Shelter.Collider.gameObject:SetActive(true)
	end
	local ShelterBuffOff = function(self)
		self:ShelterBuffOff()
		self.Shelter.Collider.gameObject:SetActive(false)
	end
	util.hotfix_ex(CS.GF.Battle.BattleCharacterController,'GetAxisX',GetAxisX)
	util.hotfix_ex(CS.GF.Battle.BattleCharacterController,'GetAxisY',GetAxisY)
	util.hotfix_ex(CS.GF.Battle.BattleCharacterController,'ShelterBuffOn',ShelterBuffOn)
	util.hotfix_ex(CS.GF.Battle.BattleCharacterController,'ShelterBuffOff',ShelterBuffOff)
end
Skill1Off = function()
	Skill1:SetActive(false)	
end
local skilltween = false
local healthPercent = 0
Update = function()
	if not thisFrameJoyStick then
		if isMoving then
			isMoving = false
			character:SetMemberAnimation("wait", 1);
		end
	end
	thisFrameJoyStick = false
	if CheckWin() and not winFunctionFlag then
		winFunctionFlag = true
		GameFinish()
	end
	if CountTime then
		countdownTimer = BattleController.CurBattleTime
		TextCountdown.text = string.format("%.2f",(countdownTimer))
	end
	if character.conditionListSelf:GetTierByID(SkillBuffID) > 0 then
		Skill1:SetActive(true)
		skilltween = false
	else
		if not skilltween then
			skilltween = true
			TweenplaySkill1Off:DoTween()
		end		
	end
	local t = healthPercent
	healthPercent = character.gun.life / character.gun.maxLife
	if healthPercent <= 1/3 and t > 1/3 then
		GoExtraTime:SetActive(true)
		TextExtraTime:SetActive(false)
		TextExtraTime:SetActive(true)
		ExtraTime = 2 * eachExtra
		TextExtraTime:GetComponent(typeof(CS.ExText)).text = "+"..ExtraTime.."s"
	else
		if healthPercent <= 2/3 and t > 2/3 then
			GoExtraTime:SetActive(true)
			TextExtraTime:SetActive(false)
			TextExtraTime:SetActive(true)
			ExtraTime = 1 * eachExtra
			TextExtraTime:GetComponent(typeof(CS.ExText)).text = "+"..ExtraTime.."s"
		end
	end
	if isWaitForEndAnim then
		WaitForEndAnimTimer = WaitForEndAnimTimer + CS.UnityEngine.Time.deltaTime
	end		
end
function CheckWin()
	local DeathBuffTier = character.conditionListSelf:GetTierByID(WinBuffID)
	return (DeathBuffTier > 0)
end
function GameFinish()
	print("GameSet!")
	isCountingTime = false
	isWaitForEndAnim = true
	CS.BattleFrameManager.StopTime(true,99999)
	--showPanel
	ShowResult()
end
function EndGame()
	if WaitForEndAnimTimer >= EndAnimWaitTime then
		CS.BattleFrameManager.ResumeTime()
		for i=0,BattleController.enemyTeamHolder.listCharacter.Count-1 do
			local DamageInfo = CS.GF.Battle.BattleDamageInfo()
			BattleController.enemyTeamHolder.listCharacter[i]:UpdateLife(DamageInfo, -999999)
		end
		ResultGO:SetActive(false)
		CS.UnityEngine.Object.Destroy(self.gameObject)
	end
end
function ShowResult()
	print("ShowResult")
	self.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = CS.UnityEngine.Vector2(0,0)
	ResultGO:SetActive(true)
	BtnClose:GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
			EndGame()			
		end)
	if CS.GameData.userInfo ~= nil then
		TextResultName:GetComponent(typeof(CS.ExText)).text = CS.GameData.userInfo.name
		TextResultID:GetComponent(typeof(CS.ExText)).text ="UID:"..CS.GameData.userInfo.userId
	end
	countdownTimer = countdownTimer + ExtraTime
	local countdownMinute = math.modf(countdownTimer / 60)
	local countdownSec = math.modf(countdownTimer - countdownMinute * 60) 
	TextTime:GetComponent(typeof(CS.ExText)).text = string.format("%02d",(countdownMinute))..":"..string.format("%02d",(countdownSec))
	TextTimeShadow:GetComponent(typeof(CS.ExText)).text = "00:" .. TextTime:GetComponent(typeof(CS.ExText)).text
	if isHK416 then
		ResultInfo1:SetActive(true)
		ResultInfo2:SetActive(false)
		ImgResultCharacter1:SetActive(true)
		ImgResultCharacter2:SetActive(false)
	else
		ResultInfo1:SetActive(false)
		ResultInfo2:SetActive(true)
		ImgResultCharacter1:SetActive(false)
		ImgResultCharacter2:SetActive(true)
	end
	if countdownTimer <= 90 then
		ImgRank:GetComponent(typeof(CS.ExImage)).sprite = RankSpriteHolder.listSprite[3]
		ImgRankBright:GetComponent(typeof(CS.ExImage)).sprite = RankSpriteHolder.listSprite[3]
	else
		if countdownTimer <= 120 then
			ImgRank:GetComponent(typeof(CS.ExImage)).sprite = RankSpriteHolder.listSprite[2]
			ImgRankBright:GetComponent(typeof(CS.ExImage)).sprite = RankSpriteHolder.listSprite[2]
		else
			if countdownTimer <= 150 then
				ImgRank:GetComponent(typeof(CS.ExImage)).sprite = RankSpriteHolder.listSprite[1]
				ImgRankBright:GetComponent(typeof(CS.ExImage)).sprite = RankSpriteHolder.listSprite[1]
			else
				ImgRank:GetComponent(typeof(CS.ExImage)).sprite = RankSpriteHolder.listSprite[0]
				ImgRankBright:GetComponent(typeof(CS.ExImage)).sprite = RankSpriteHolder.listSprite[0]
			end
		end
	end
	--CS.GF.Battle.BattleController.Instance.statistics:SetData(CS.GF.Battle.BattleStatistics.true_time, math.floor(countdownTimer * 30))
end
--depose
OnDestroy =function()
	character = nil
	mCurSkill ={}
	xlua.hotfix(CS.GF.Battle.BattleController,'RefreshFriendlyTargetList',nil)
end
GetTimeFormat = function(value)
	local value2 = math.floor((value - math.floor(value)) * 10)
	local t = string.format("<size=90>%02d</size>:%01d",math.floor(value),value2)
	return t
end
