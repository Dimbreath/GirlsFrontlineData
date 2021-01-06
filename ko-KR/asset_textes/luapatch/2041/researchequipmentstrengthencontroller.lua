local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchEquipmentStrengthenController)
local ResearchEquipmentStrengthenController_OnClickCapsuleDown = function(self)
	
	if (self.currentEquip == nil) 
	then
		return;
	end
	--local needExp = self.currentEquip:GetTotalExpToLevel(CS.Data.GetInt("equip_lv_limit")) - self.currentEquip:GetTotalExpToLevel(self.currentEquip.equip_level);
	local needExp = self.currentEquip:GetTotalExpToLevel(CS.Data.GetInt("equip_lv_limit")) - self.currentEquip.equip_exp;
	if(self.capsuleAmount == 0)
	then
		--local currentLevelHasExp = (self.currentEquip:GetTotalExpToLevel(self.currentEquip.equip_level) + self.expFromFeedEquipment + self.expCapsule - (self.currentEquip:GetTotalExpToLevel(self.currentEquip.equip_level + self:GetLevelToBeAdded(self.expFromFeedEquipment)))) + self.currentEquip:GetCurrentLevelExp();
		local currentLevelHasExp = self.expFromFeedEquipment + self.expCapsule;
		self:OnClickCapsule(CS.Mathf.CeilToInt((needExp - currentLevelHasExp)*1.0 / (CS.Data.GetInt("equip_intensive_exp")*1.0*((100.0 + CS.Data.GetReductionFactorByFunctonSkillID(113)) / 100.0))));
	else
		self:OnClickCapsule(-1);
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
	self.expCapsule=CS.Mathf.FloorToInt(exp * ((100.0 + CS.Data.GetReductionFactorByFunctonSkillID(113)) / 100.0));
	print(self.expCapsule);
	self:UpdateResourcePreview();
    self:RefreshLevelAndExpTxt();
 
	 
end
util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'OnClickCapsuleDown',ResearchEquipmentStrengthenController_OnClickCapsuleDown)
util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'OnClickCapsule',ResearchEquipmentStrengthenController_OnClickCapsule)