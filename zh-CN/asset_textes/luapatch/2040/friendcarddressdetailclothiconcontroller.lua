local util = require 'xlua.util'
xlua.private_accessible(CS.FriendCardDressDetailClothIconController)

local FriendCardDressDetailClothIconController_InitView = function(self,uniform)
	self:InitView(uniform);
	self.imageGenderIcon.gameObject:SetActive(false);
end
util.hotfix_ex(CS.FriendCardDressDetailClothIconController,'InitView',FriendCardDressDetailClothIconController_InitView)