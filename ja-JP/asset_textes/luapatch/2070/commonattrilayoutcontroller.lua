local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAttriLayoutController)

local _InitSangvis = function(self,gun,isGunState)
	self:InitSangvis(gun,isGunState);
	if gun.armor == 0 then
		self.txArmor.transform.parent.gameObject:SetActive(false);
		--self:CloseText(self.txArmor, 1);
	end
end

util.hotfix_ex(CS.CommonAttriLayoutController,'InitSangvis',_InitSangvis)
