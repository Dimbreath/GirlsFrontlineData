local util = require 'xlua.util'
xlua.private_accessible(CS.BattleManualSkillController)
xlua.private_accessible(CS.GF.Battle.BattleConditionList)
local currentTier
local targetBuffType = 405
local LifeBarTierBGTable = {}
local LifeBarTierRingTable = {}
local LifeBarTier = {}
local LifeBarFillTier = {}
local MaxTierTable = {}
local DelayTable = {}
--处理新版炮狙显示效果：在接受到显示Buff时，若其身上有符合炮狙蓄力Buff类型（=405）的Buff，为该对应角色在血条上方显示炮狙显示效果。
local OnDisplay = function(self,currentDisplayedCondition)
	self:OnDisplay(currentDisplayedCondition)
	local tempList = self.mCurChar.conditionListSelf
	if tempList.mDicTypeCount:ContainsKey(targetBuffType) then			
		for k,v in pairs(tempList.ConditionList) do
			if v.buffCfg.type == targetBuffType then
				MaxTierTable[self.index] = v.buffCfg.max_tier
				break
			end
		end
		self.mCurChar.lifeBar.transform:Find("Bullet").gameObject:SetActive(true)
		--由策划填写到显示Buff的fix_damage参数中（单位是帧），处理技能释放后的延时发射效果，达到一致性
		DelayTable[self.index] = currentDisplayedCondition.buffCfg.fix_damage / 30

		if LifeBarTierBGTable[self.index] == nil or LifeBarTierBGTable[self.index]:isNull() then
			LifeBarTierBGTable[self.index] = self.mCurChar.lifeBar.transform:Find("Bullet"):Find("BulletFill")
			LifeBarTierRingTable[self.index] = self.mCurChar.lifeBar.transform:Find("Bullet"):Find("Img_LightRing")		
		end

		if LifeBarTier[self.index] == nil or LifeBarTier[self.index]:isNull() then
			LifeBarTier[self.index] = LifeBarTierBGTable[self.index]:Find("Img_Fill"):GetComponent(typeof(CS.ExImage))
		end
		if LifeBarFillTier[self.index] == nil or LifeBarFillTier[self.index]:isNull() then
			LifeBarFillTier[self.index] = LifeBarTierBGTable[self.index]:Find("Img_FilltHighlight"):GetComponent(typeof(CS.ExImage))
		end
		local currentTier = nil
		local duration = nil
		currentTier,duration = self.mCurChar.conditionListSelf:GetTierByType(targetBuffType)
		ChangeBuffTier(currentTier,self.index)
	end
	
end
local OnDisplayDisable = function(self)
	
	self:OnDisplayDisable()
	local tempList = self.mCurChar.conditionListSelf
	if tempList.mDicTypeCount:ContainsKey(targetBuffType) then			
		if LifeBarTier[self.index] ~= nil and self.imageIconGlow.gameObject.activeSelf == false then		
			SetOff(self.index)
		end
	end
end
ChangeBuffTier = function(currentTier,index)
	if currentTier > 0 then
		Reset(index)
		LifeBarTierBGTable[index]:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1
		local fillAmount = currentTier / MaxTierTable[index]
		LifeBarTier[index].fillAmount = fillAmount
		LifeBarFillTier[index].fillAmount = fillAmount
	else
		SetOff(index)
	end

end
--子弹击发效果
SetOff = function(index)
	
	local LifeBarTierBGTweens = LifeBarTierBGTable[index].gameObject:GetComponents(typeof(CS.TweenPlay))
	local LifeBarRingTweens = LifeBarTierRingTable[index].gameObject:GetComponents(typeof(CS.TweenPlay))
	for i=0,LifeBarTierBGTweens.Length-1 do
		if i >= LifeBarTierBGTweens.Length-2 then
			LifeBarTierBGTweens[i].loopTime = math.ceil( DelayTable[index] / LifeBarTierBGTweens[i].duration )
			LifeBarTierBGTweens[i]:DoTween()
		else
			LifeBarTierBGTweens[i].delay = DelayTable[index]
			LifeBarTierBGTweens[i]:DoTween()
		end		
	end
	for i=0,LifeBarRingTweens.Length-1 do
		if i == LifeBarRingTweens.Length-1 then
			LifeBarRingTweens[i].delay = DelayTable[index] - 0.05
		else
			LifeBarRingTweens[i].delay = DelayTable[index]	
		end		
	end
	LifeBarTierRingTable[index].gameObject:SetActive(true)
	--LifeBarTierBGTable[index]:Find("Img_FilltHighlight").gameObject:SetActive(false)
	local FillHighLightTween =  LifeBarTierBGTable[index]:Find("Img_FilltHighlight").gameObject:GetComponents(typeof(CS.TweenPlay))
	FillHighLightTween[0].enabled = false
	FillHighLightTween[1]:DoTween()
	local HighLightTween =  LifeBarTierBGTable[index]:Find("Img_BulletHighlight").gameObject:GetComponents(typeof(CS.TweenPlay))
	HighLightTween[0].enabled = false
	HighLightTween[1]:DoTween()
	--LifeBarTierBGCanvas.alpha = 0
	--LifeBarTier.fillAmount = 0
end
--重置子弹位置
Reset = function(index)
	if LifeBarTierRingTable[index].gameObject.activeSelf == true then
		LifeBarTierRingTable[index].gameObject:SetActive(false)
		LifeBarTierBGTable[index]:GetComponent(typeof(CS.UnityEngine.RectTransform)).localPosition = CS.UnityEngine.Vector3(0,0,0)
		LifeBarTierBGTable[index]:Find("Img_FilltHighlight").gameObject:SetActive(true)
		local FillHighLightTween =  LifeBarTierBGTable[index]:Find("Img_FilltHighlight").gameObject:GetComponents(typeof(CS.TweenPlay))
		FillHighLightTween[0].enabled = true
		local HighLightTween =  LifeBarTierBGTable[index]:Find("Img_BulletHighlight").gameObject:GetComponents(typeof(CS.TweenPlay))
		HighLightTween[0].enabled = true
	end
end
util.hotfix_ex(CS.BattleManualSkillController,'OnDisplay',OnDisplay)
util.hotfix_ex(CS.BattleManualSkillController,'OnDisplayDisable',OnDisplayDisable)