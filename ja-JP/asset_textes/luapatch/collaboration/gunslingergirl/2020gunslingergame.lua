local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
xlua.private_accessible(CS.CommonController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.BattleManualSkillController)
xlua.private_accessible(CS.GF.Battle.BattleController)

local character = nil
local mCurSkill ={}
local maxX = 5
local minX = -1
local maxY = 2
local minY = -3.6
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

SkillActive = function(active,showCD)
	
end
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
end
JoyStickMove = function(input)
	local XPara = speedXPara
	if input.value <= 0 then
		return
	end
	thisFrameJoyStick = true
	local x =
	CS.Mathf.Clamp(
		character.transform.localPosition.x - math.sin(input.eulerAngle) * character.realtimeSpeed * XPara * 1,
		minX,
		maxX
	)
	local y =
	CS.Mathf.Clamp(
		character.transform.localPosition.z + math.cos(input.eulerAngle) * character.realtimeSpeed * speedYPara * input.value,
		minY,
		maxY
	)
	--print("原始速度:"..character.realtimeSpeed .." ".."最终速度:"..character.gun.speed * XPara * input.value)
	
	
	local offset = CS.UnityEngine.Vector3(character.transform.localPosition.x, 0, y)
	if y == character.transform.localPosition.y then
		if isMoving then
			isMoving = false
			character:SetMemberAnimation("wait", 1);
		end
	else 
		if isMoving == false then
			isMoving = true
			character:SetMemberAnimation("move", 1);
		end
	end
	character.transform.localPosition = offset
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
	textTime = TextTime:GetComponent(typeof(CS.ExText))
end

--Start: 加载组件
Start = function()
	--禁止人物拖动
	CS.GF.Battle.BattleController.Instance.isTheaterPerform = true
	CS.GF.Battle.SkillUtils.AutoSkill = false
	
	--注册相机
	self.transform:SetParent(CS.BattleUIController.Instance.transform:Find('UI'),false)
	--self:GetComponent('Canvas').worldCamera = CS.UnityEngine.Camera.main
	--注册人物
	if character == nil then
		character = CS.BattleLuaUtility.GetCharacterByCode('Rico')
	end
	--注册人物技能
	mCurSkill[1] = character.gun:GetSkillByGroupId(406601)
	mCurSkill[2] = character.gun:GetSkillByGroupId(406611)
	-- 人物扶正
	--character.listMember[0].transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
	
	-- 关闭自动技能 --------打完要记得调回去！（LoadAutoSkillPref）---------
	
	--countDown:GetComponent('Transform')
	--BtnTest:GetComponent('Button').onClick:AddListener(TestFunc)
	
	CS.BattleLuaUtility.SwitchUIManualPannel(false) -- 关闭手动技能面板
	
	JoyStick:GetComponent(typeof(CS.Joystick)).JoystickMoveHandle = JoyStickMove
	JoyStick:GetComponent(typeof(CS.Joystick)).JoystickEndHandle = JoyStickEnd
	JoyStick:GetComponent(typeof(CS.Joystick)).JoystickBeginHandle = JoyStickBegin
	
	
	--txCD = goCD:GetComponent('Text');
	InitSkill1(SkillLabel1,mCurSkill[1],1)
	--InitSkill1(SkillLabel2,mCurSkill[2],2)
	
end
Update = function()
	if not thisFrameJoyStick then
		if isMoving then
			isMoving = false
			character:SetMemberAnimation("wait", 1);
		end
	end
	thisFrameJoyStick = false
	if CountTime then
		timecount = timecount + CS.UnityEngine.Time.deltaTime
		textTime.text= GetTimeFormat(timecount)
		local currentTier
		local dutarion
		currentTier,dutarion = character.conditionListSelf:GetTierByID(4231)
		if currentTier ~= 0 then
			CountTime = false
		end
	end

	
end
--depose
OnDestroy =function()
	character = nil
	mCurSkill ={}
end
GetTimeFormat = function(value)
	local value2 = math.floor((value - math.floor(value)) * 10)
	local t = string.format("<size=90>%02d</size>:%01d",math.floor(value),value2)
	return t
end
