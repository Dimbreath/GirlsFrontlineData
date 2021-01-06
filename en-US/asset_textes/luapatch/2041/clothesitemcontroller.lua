local util = require 'xlua.util'
xlua.private_accessible(CS.ClothesItemController)

local myOnClickChooseGoodItem = function(self, good)
	--  先记录原来的状态
	local clothesStoreController = CS.ClothesStoreController.Instance;
	local goodStatus;
	local itemActive;
	if(good.isSelected == false and clothesStoreController.readyBuyGoods:ContainsKey(self.info.type)) then
		local itemCloth = clothesStoreController.clothesItemControllerMap[clothesStoreController.readyBuyGoods[self.info.type].id];
		goodStatus = itemCloth.good.isSelected;
		itemActive = itemCloth.img_Select.gameObject.activeSelf;
	end
	-- 执行原来的流程
    self:OnClickChooseGoodItem(good)
	-- 把错误改变的状态复位
	if(good.isSelected == false  and clothesStoreController.readyBuyGoods:ContainsKey(self.info.type)) then
		local itemCloth = clothesStoreController.clothesItemControllerMap[clothesStoreController.readyBuyGoods[self.info.type].id];
		itemCloth.good.isSelected = goodStatus;
		itemCloth.img_Select.gameObject.activeSelf = itemActive;
		-- 执行新的正确逻辑
		local mallGood = clothesStoreController.dataSource:Find(
				function(s) 
				local ID = clothesStoreController.readyBuyGoods[self.info.type].id;
				return s.id == ID;
			end)		
		mallGood.isSelected = false;
		for i = 0, clothesStoreController.clothesLayout:GetChildList().Count-1 do
			local clothesItem = clothesStoreController.clothesLayout:GetChildList()[i]:GetComponent("ClothesItemController");
			if(clothesItem.good.id == mallGood.id) then
				clothesItem.img_Select.gameObject:SetActive(false);
				break;
			end
		end
	end
end
util.hotfix_ex(CS.ClothesItemController,'OnClickChooseGoodItem',myOnClickChooseGoodItem)