local util = require 'xlua.util'
xlua.private_accessible(CS.GashaSkinDisplayRightController)

local _UpdateCurrentSkinInfo = function(self,prize)
	self:UpdateCurrentSkinInfo(prize);
	if self.isBlackPool == false then
		self.btnExchange.interactable = true;
	end
end

util.hotfix_ex(CS.GashaSkinDisplayRightController,'UpdateCurrentSkinInfo',_UpdateCurrentSkinInfo)


