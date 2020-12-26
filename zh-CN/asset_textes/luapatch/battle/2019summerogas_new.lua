local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
xlua.private_accessible(CS.CommonController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.BattleManualSkillController)

local character = nil
local mCurSkill ={}
local maxX = 5
local minX = -1
local maxY = 4
local minY = -6
local txCD = nil
--X分量的系数
local speedXPara = 0.02
--Y分量的系数
local speedYPara = 0.02
--后撤移动时的额外系数
local XBackMovePara = 0.8
local moveFowardID = 40540701
local moveBackID = 40540801
local cfgMoveFoward = nil
local cfgMoveBack = nil

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
		skillLabelController.imgBgActive.sprite = skillLabelController.arrSprBg[1]
        skillLabelController.imgBgActive.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
        skillLabelController.imgBgDisable.sprite = skillLabelController.arrSprBg[1]
        skillLabelController.imgBgDisable.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
        skillLabelController.imgBgPassive.sprite = skillLabelController.arrSprBg[1]
        skillLabelController.imgBgPassive.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
        skillLabelController.imageHintBg.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
	end
	if pos == 3 then
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
	if input.eulerAngle < math.pi then
		XPara =XPara * XBackMovePara
		if cfgMoveFoward ~= nil then
			CS.GF.Battle.SkillUtils.GenBuff(
				CS.GF.Battle.BattleSkillCfgEx(cfgMoveFoward, false, nil, nil),
				character.listMember[0],
				cfgMoveFoward.buffSelf,
				{-1},
				0
			)
		end
		if cfgMoveBack ~= nil then
			CS.GF.Battle.SkillUtils.GenBuff(
				CS.GF.Battle.BattleSkillCfgEx(cfgMoveBack, false, nil, nil),
				character.listMember[0],
				cfgMoveBack.buffSelf,
				{1},
				0
			)
		end
	else
		if cfgMoveFoward ~= nil then
			CS.GF.Battle.SkillUtils.GenBuff(
				CS.GF.Battle.BattleSkillCfgEx(cfgMoveFoward, false, nil, nil),
				character.listMember[0],
				cfgMoveFoward.buffSelf,
				{1},
				0
			)
		end
		if cfgMoveBack ~= nil then
			CS.GF.Battle.SkillUtils.GenBuff(
				CS.GF.Battle.BattleSkillCfgEx(cfgMoveBack, false, nil, nil),
				character.listMember[0],
				cfgMoveBack.buffSelf,
				{-1},
				0
			)
		end
	end
    local x =
        CS.Mathf.Clamp(
        character.transform.localPosition.x - math.sin(input.eulerAngle) * character.realtimeSpeed * XPara * input.value,
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
    local offset = CS.UnityEngine.Vector3(x, 0, y)
    character.transform.localPosition = offset
end

JoyStickBegin = function(input)
	
end

JoyStickEnd = function(input)
	--取消BUFF，代表角色停止移动
	if cfgMoveFoward ~= nil and character:isNull() == false and character.listMember[0]:isNull() == false then
		CS.GF.Battle.SkillUtils.GenBuff(
			CS.GF.Battle.BattleSkillCfgEx(cfgMoveFoward, false, nil, nil),
			character.listMember[0],
			cfgMoveFoward.buffSelf,
			{-1},
			0
		)
	end
	if cfgMoveBack ~= nil and character:isNull() == false and character.listMember[0]:isNull() == false then
		CS.GF.Battle.SkillUtils.GenBuff(
			CS.GF.Battle.BattleSkillCfgEx(cfgMoveBack, false, nil, nil),
			character.listMember[0],
			cfgMoveBack.buffSelf,
			{-1},
			0
		)
	end
end

TriggerInvincible = function()
	--增加一个Buff使得角色暂时无敌
    local cfg = CS.GameData.listBTSkillCfg:GetDataById(40540601)
    if cfg ~= nil and character:isNull() == false and character.listMember[0]:isNull() == false then
        --产生技能所带的buff
        CS.GF.Battle.SkillUtils.GenBuff(
            CS.GF.Battle.BattleSkillCfgEx(cfg, false, nil, nil),
            character.listMember[0],
            cfg.buffSelf,
            cfg.buffSelfNum,
            1
        )
    end
end

--Awake：初始化数据
Awake = function()
    -- 关闭自动释放技能
end

--Start: 加载组件
Start = function()
	--禁止人物拖动并锁定镜头
	CS.BattleInteractionController.isGuideInteractable = false
	CS.BattleInteractionController.isGuideCanNotScale = false
	CS.BattleInteractionController.isGuideCanNotOffset = false
	CS.GF.Battle.SkillUtils.AutoSkill = false
	CS.GF.Battle.BattleController.Instance.resetAutoSkill = true
	CS.GF.Battle.BattleController.Instance.resetCameraLock = true
	cfgMoveFoward = CS.GameData.listBTSkillCfg:GetDataById(moveFowardID)
	cfgMoveBack = CS.GameData.listBTSkillCfg:GetDataById(moveBackID)
	--注册相机
	self.transform:SetParent(CS.BattleUIController.Instance.transform:Find('UI'),false)
	--self:GetComponent('Canvas').worldCamera = CS.UnityEngine.Camera.main
	--注册人物
    if character == nil then
        character = CS.BattleLuaUtility.GetCharacterByCode('M4A1Mod_Ogas')
    end
	--注册人物技能
    mCurSkill[1] = character.gun:GetSkillByGroupId(405403)
	mCurSkill[2] = character.gun:GetSkillByGroupId(405402)
	mCurSkill[3] = character.gun:GetSkillByGroupId(405405)
    -- 人物扶正
    character.listMember[0].transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
    -- 修改碰撞盒
	character:InitCollider()

    -- 关闭自动技能 --------打完要记得调回去！（LoadAutoSkillPref）---------

	--countDown:GetComponent('Transform')
    --BtnTest:GetComponent('Button').onClick:AddListener(TestFunc)

    CS.BattleLuaUtility.SwitchUIManualPannel(false) -- 关闭手动技能面板

    JoyStick:GetComponent(typeof(CS.Joystick)).JoystickMoveHandle = JoyStickMove
    JoyStick:GetComponent(typeof(CS.Joystick)).JoystickEndHandle = JoyStickEnd
    JoyStick:GetComponent(typeof(CS.Joystick)).JoystickBeginHandle = JoyStickBegin

    --print(123)
    character.OnBarrageHit = TriggerInvincible
	
    --txCD = goCD:GetComponent('Text');
	InitSkill1(SkillLabel1,mCurSkill[1],1)
	InitSkill1(SkillLabel2,mCurSkill[2],2)
	InitSkill1(SkillLabel3,mCurSkill[3],3)
	
end
Update = function()
end
--depose
OnDestroy =function()
	character = nil
	mCurSkill ={}
end

