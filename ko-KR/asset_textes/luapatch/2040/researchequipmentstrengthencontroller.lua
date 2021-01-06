local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchEquipmentStrengthenController)
xlua.private_accessible(CS.Mathf)
xlua.private_accessible(CS.Data)
local myOnClickCapsuleDown = function(self)
	
	if (self.currentEquip == nil) 
	then
		return;
	end
	local needExp = self.currentEquip:GetTotalExpToLevel(CS.Data.GetInt("equip_lv_limit")) - self.currentEquip:GetTotalExpToLevel(self.currentEquip.equip_level);
	if(self.capsuleAmount == 0)
	then
		local currentLevelHasExp = (self.currentEquip:GetTotalExpToLevel(self.currentEquip.equip_level) + self.expFromFeedEquipment + self.expCapsule - (self.currentEquip:GetTotalExpToLevel(self.currentEquip.equip_level + self:GetLevelToBeAdded(self.expFromFeedEquipment)))) + self.currentEquip:GetCurrentLevelExp();
		self:OnClickCapsule(CS.Mathf.CeilToInt((needExp - self.expFromFeedEquipment - currentLevelHasExp) / (CS.Data.GetInt("equip_intensive_exp")*1.0*((100.0 + CS.Data.GetReductionFactorByFunctonSkillID(113)) / 100.0))));
	else
		self:OnClickCapsule(-1);
	end
end
local myRefreshLevelAndExpTxt = function(self)
	self:RefreshLevelAndExpTxt();
	if(self.currentEquip ~= nil) then
		if (self.currentEquip.equip_level < self.currentEquip.equip_level + self:GetLevelToBeAdded(self.expFromFeedEquipment) and self.currentEquip.equip_level ~= CS.Data.GetInt("equip_lv_limit") - 1) then
			self.basicExpBar.fillAmount = 0;
		else
			self.basicExpBar.fillAmount = self.currentEquip:GetCurrentLevelExp() / self.currentEquip:CalculateExpToNextLevel(self.currentEquip.equip_level + 1);
		end
	end
end
local ResearchEquipmentStrengthenController_OnClickCapsule = function(self, number)
	if self.currentLabel.equip == nil then
		return;
	end
	if number > 0 and self.overMax==true then
		return;
	end


	self.capsuleAmount = CS.Mathf.Clamp(self.capsuleAmount + number, 0, CS.GameData.userInfo.equipCapsule);
    self.textCapsule.text = string.format("%d/%d", self.capsuleAmount, CS.GameData.userInfo.equipCapsule);

    self.expCapsule = (self.capsuleAmount * CS.Data.GetInt("equip_intensive_exp"));
    local exp=self.expCapsule;
    print(self.expCapsule);
	self.expCapsule=CS.Mathf.FloorToInt(exp * ((100 + CS.Data.GetReductionFactorByFunctonSkillID(113)) / 100.0));
	print(self.expCapsule);
	self:UpdateResourcePreview();
    self:RefreshLevelAndExpTxt();
 
	 
end

util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'OnClickCapsuleDown',myOnClickCapsuleDown)
util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'RefreshLevelAndExpTxt',myRefreshLevelAndExpTxt)
util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'OnClickCapsule',ResearchEquipmentStrengthenController_OnClickCapsule)