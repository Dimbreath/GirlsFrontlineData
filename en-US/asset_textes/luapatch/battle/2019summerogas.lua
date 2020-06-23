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
local speedX = 0.1
local speedY = 0.1


SkillActive = function(active,showCD)
    
end
InitSkill1 = function(SkillLabel,mCurSkill,pos)
	local skillLabelController
    skillLabelController = SkillLabel:GetComponent('BattleManualSkillController')
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
    skillLabelController.imageIcon:GetComponent('RectTransform').sizeDelta = CS.UnityEngine.Vector2(120, 120)
    skillLabelController.imageIcon:GetComponent('RectMask2D').enabled = true
	local pic = CS.CommonController.LoadSmallPic(character.gun, skillLabelController.imageIcon.transform, CS.UnityEngine.Vector2.zero)
        if pic ~= nil then
            pic:ShowTuJian(nil, 0.4, 0.6)
            local transPic = pic:GetComponent('RectTransform')
            transPic.localScale = CS.UnityEngine.Vector3(0.75, 0.3, 1)
            transPic.anchoredPosition = CS.UnityEngine.Vector2(0, 18)
        end
	skillLabelController.imageIcon.gameObject:SetActive(true)
    skillLabelController.goSkill2Perf:SetActive(false)
    skillLabelController.animCDDone.gameObject:SetActive(false)
    skillLabelController.animActive.gameObject:SetActive(false)
    skillLabelController.imageHintBg.gameObject:SetActive(false)
	if mCurSkill ~= nil then
		print("-----------"..pos)
		 local skillIcon = CS.CommonController.InstantiateSkillIcon(mCurSkill.info:GetIconCodeBySkin(character.gun.currentSkinId))
		 local rectIcon = skillIcon:GetComponent('RectTransform')
		 rectIcon:SetParent(skillLabelController.objSkill.transform,false)
		 rectIcon:SetSiblingIndex(0)
         rectIcon:SetSizeWithCurrentAnchors(CS.UnityEngine.RectTransform.Axis.Horizontal, 100)
         rectIcon:SetSizeWithCurrentAnchors(CS.UnityEngine.RectTransform.Axis.Vertical, 100)
	end
	skillLabelController:_Active(true)
end
JoyStickMove = function(input)
    local x =
        CS.Mathf.Clamp(
        character.transform.localPosition.x - math.sin(input.eulerAngle) * speedX * input.value,
        minX,
        maxX
    )
    local y =
        CS.Mathf.Clamp(
        character.transform.localPosition.z + math.cos(input.eulerAngle) * speedY * input.value,
        minY,
        maxY
    )
    local offset = CS.UnityEngine.Vector3(x, 0, y)
    character.transform.localPosition = offset
end

JoyStickBegin = function(input)
    character:SetMemberAnimation('move')
end

JoyStickEnd = function(input)
    character:SetMemberAnimation('wait')
end

TriggerInvincible = function(input)
    local cfg = CS.GameData.listBTSkillCfg:GetDataById(20010101)
    if cfg ~= nil then
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
	--禁止人物拖动 打完要记得调回去
	CS.BattleInteractionController.isGuideInteractable = false
	--注册相机
	self.transform:SetParent(CS.BattleUIController.Instance.transform:Find('UI'),false)
	--self:GetComponent('Canvas').worldCamera = CS.UnityEngine.Camera.main
	--注册人物
    if character == nil then
        character = CS.BattleLuaUtility.GetCharacterByCode('M1873')
    end
	--注册人物技能
    mCurSkill[1] = character.gun:GetSkillByGroupId(102112)
	mCurSkill[2] = character.gun:GetSkillByGroupId(103106)
	mCurSkill[3] = character.gun:GetSkillByGroupId(102701)
    -- 人物扶正
    character.listMember[0].transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
    -- 修改碰撞盒
    local goCollider = CS.UnityEngine.GameObject()
    goCollider.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
    goCollider.transform:SetParent(character.listMember[0].transform, false)
    local collider = goCollider:AddComponent(typeof(CS.UnityEngine.BoxCollider))
    collider.isTrigger = false
    collider.center = CS.UnityEngine.Vector3(0, 0.875, 0)
    collider.size = CS.UnityEngine.Vector3(0.25, 1.75, 0.28)
    goCollider.layer = 20
    -- 关闭自动技能 --------打完要记得调回去！（LoadAutoSkillPref）---------
    CS.GF.Battle.SkillUtils.AutoSkill = false
	--countDown:GetComponent('Transform')
    --BtnTest:GetComponent('Button').onClick:AddListener(TestFunc)

    CS.BattleLuaUtility.SwitchUIManualPannel(false) -- 关闭手动技能面板

    JoyStick:GetComponent('Joystick').JoystickMoveHandle = JoyStickMove
    JoyStick:GetComponent('Joystick').JoystickEndHandle = JoyStickEnd
    JoyStick:GetComponent('Joystick').JoystickBeginHandle = JoyStickBegin

    print(123)
    character.OnBarrageHit = TriggerInvincible
	
    --txCD = goCD:GetComponent('Text');
	InitSkill1(SkillLabel1,mCurSkill[1],1)
	InitSkill1(SkillLabel2,mCurSkill[2],2)
	InitSkill1(SkillLabel3,mCurSkill[3],3)
	
end
--Update: 对于每个技能而言 查看其状态（CD中/可施放/待施放）并更新UI
Update = function()
end
--depose
OnDestroy =function()
	character = nil
	mCurSkill ={}
end

