local util = require 'xlua.util'
xlua.private_accessible(CS.CommonBundleConfirmBoxController)

local RefreshMallGoodPrice = function(self,isSkin)
	self:RefreshMallGoodPrice(isSkin);
	self.MallNumAdjust.gameObject:SetActive(self.currentMallGood.type ~= CS.GoodType.payToFirst and self.currentMallGood.type ~= CS.GoodType.payToGiftbag);
end

util.hotfix_ex(CS.CommonBundleConfirmBoxController,'RefreshMallGoodPrice',RefreshMallGoodPrice)