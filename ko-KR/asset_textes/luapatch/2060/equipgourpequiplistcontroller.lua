local util = require 'xlua.util'
xlua.private_accessible(CS.EquipGourpEquipListController)
local myScrollViewEnd = function(self)
	self:ScrollViewEnd()
    if self.equipList ~= nil and self.equipList.Count > 0 then
        local equip = self.equipList[self.viewport.minEleNum];
        if self.currentSelectGun ~= nil then
			if equip.info.listFitGunInfoId.Count ~= 0 then
                if 	equip.info.listFitGunInfoId:Contains(self.currentSelectGun.info.id) == false then
                    self.equipGroup:SetActive(false);
                    self.unloadGroup:SetActive(false);
                    self.cantEquipGroup:SetActive(true);
				end
			end
		end
	end
end
util.hotfix_ex(CS.EquipGourpEquipListController,'ScrollViewEnd',myScrollViewEnd)