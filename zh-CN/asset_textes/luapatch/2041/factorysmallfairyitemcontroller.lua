local util = require 'xlua.util'
xlua.private_accessible(CS.FactorySmallFairyItemController)
xlua.private_accessible(CS.FactorySmallEquipItemController)
xlua.private_accessible(CS.FactorySmallGunItemController)
local InitGun = function(self,p,gun,cancelHandler,itemHolder)
	self:Init(p,gun,cancelHandler,itemHolder);
	if gun ~= nil then
		self.id = gun.id;
	end
end
local InitEquip = function(self,p,equip,cancelHandler,itemHolder)
	self:Init(p,equip,cancelHandler,itemHolder);
	if equip ~= nil then
		self.id = equip.id;
	end
end
local InitFairy = function(self,p,fairy,cancelHandler,itemHolder)
	self:Init(p,fairy,cancelHandler,itemHolder);
	if fairy ~= nil then
		self.id = fairy.id;
	end
end
util.hotfix_ex(CS.FactorySmallFairyItemController,'Init',InitFairy)
util.hotfix_ex(CS.FactorySmallEquipItemController,'Init',InitFairy)
util.hotfix_ex(CS.FactorySmallGunItemController,'Init',InitFairy)
