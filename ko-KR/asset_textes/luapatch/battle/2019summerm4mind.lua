local util = require 'xlua.util'
xlua.private_accessible(CS.CommonController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.GameData)

local TargetBuffID = 3180
local MaxTier = nil
local characterCode = 'M4A1_Boss'
local character = nil
local dutarion = nil
local NeuralBarSlider =nil
local currentWidth = nil
local currentTier = nil
local nextWidth = nil
local timer = nil
local Mathf = nil
local prevTier = nil

--Awake：初始化数据
Awake = function()
    -- 关闭自动释放技能
end

--Start: 加载组件
Start = function()

	currentWidth = 0
	timer = 0
	prevTier = -1
	Mathf = CS.UnityEngine.Mathf
	NeuralBarSlider = NeuralBar:GetComponent('Slider')
	NeuralBarSlider.value = 0
	--注册人物
    if character == nil or character:isNull() then
        character = CS.BattleLuaUtility.GetCharacterByCode(characterCode)		
    end
	--找Buff
	MaxTier = CS.GameData.listBTBuffCfg:GetDataById(TargetBuffID).max_tier
end
Update = function()
	timer = timer + (CS.UnityEngine.Time.deltaTime) * 0.6
	if  character ~= nil then
		currentTier,dutarion = character.conditionListSelf:GetTierByID(TargetBuffID)
		nextWidth = (currentTier / MaxTier) 
		if prevTier ~= currentTier then
			timer = 0
			prevTier = currentTier
		end
		
		NeuralBarSlider.value = Mathf.Lerp(currentWidth,nextWidth,timer)
		--if timer >= 1 then
		--	timer = 1
		--	currentWidth = nextWidth
		--end
		currentWidth = Mathf.Lerp(currentWidth,nextWidth,timer)
	end
	
end
--depose
OnDestroy =function()
	Mathf = nil
	NeuralBarSlider = nil
	character = nil
end
