local util = require 'xlua.util'
xlua.private_accessible(CS.EquipmentPresetController)
local myOnClick = function(self,b,i)
    if b == true then
		if(self.currentSlot ~= i) then
			local slotInfo = self.currentGun.info.listEquipSlot:Find( 
				function(slot)
					return slot.slotIdWithGun == i;
				end
			)
			if slotInfo ~= nil then
				self.currentSlot = i;
				CS.CommonEquipmentListController.instance.chooseEquipCategory:Clear();
                CS.CommonEquipmentListController.instance.chooseEquipCategoryTemp:Clear();
                CS.CommonEquipmentListController.instance:CreateList(CS.EquipListType.EquipPreset, CS.FormationController.Instance.gameObject, slotInfo.equipCategory, CS.EquipType.none, self.currentGun, i);
			end
		end
	end
end
local myStart = function(self)
    self:Start();
	self.firstEquipmentLockTex.text = CS.System.String.Format(CS.Data.GetLang(1591), CS.Ratio.arrEquipLevelLimit[1]);
    self.secondEquipmentTex.text = CS.System.String.Format(CS.Data.GetLang(1591), CS.Ratio.arrEquipLevelLimit[2]);
    self.thirdEquipmentTex.text = CS.System.String.Format(CS.Data.GetLang(1591), CS.Ratio.arrEquipLevelLimit[3]);
end
util.hotfix_ex(CS.EquipmentPresetController,'OnClick',myOnClick)
util.hotfix_ex(CS.EquipmentPresetController,'Start',myStart)