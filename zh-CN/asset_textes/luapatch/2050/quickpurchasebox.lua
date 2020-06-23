local util = require 'xlua.util'
xlua.private_accessible(CS.QuickPurchaseBox)

local GemBuyItemView = function(self)
	self:GemBuyItemView()
	local code = CS.GameData.userInfo.sangvisBpCode +10000
	if self.itemGood.type == CS.GoodType.gemToItem then
		for k,v in pairs(self.itemGood.package.listItemPackage) do
			print(v.info.id)
			if v.info.id == code then
				self.textPaymentDescription.text = CS.Data.GetLang(71121)
				break
			end
		end			
	end
end
local OneClickBuyItemSwitchView = function(self,isCheck,isDefault)
	if self.showingIcon ~= nil then
		CS.UnityEngine.Object.Destroy(self.showingIcon.gameObject)
	end
	self:OneClickBuyItemSwitchView(isCheck,isDefault)
end
local mySangvisMallUI = function(self)
	self:SangvisMallUI();
	if (self.sangvisMallGood.cost_num <= CS.GameData.GetItem(self.sangvisMallGood.cost_item)) then
        self.PriceTagList[0].priceTagText.color = CS.UnityEngine.Color.white;
    else
        self.PriceTagList[0].priceTagText.color = CS.UnityEngine.Color.red;
	end
end
util.hotfix_ex(CS.QuickPurchaseBox,'SangvisMallUI',mySangvisMallUI)
util.hotfix_ex(CS.QuickPurchaseBox,'GemBuyItemView',GemBuyItemView)
util.hotfix_ex(CS.QuickPurchaseBox,'OneClickBuyItemSwitchView',OneClickBuyItemSwitchView)