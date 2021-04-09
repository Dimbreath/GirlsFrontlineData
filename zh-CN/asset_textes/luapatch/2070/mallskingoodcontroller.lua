local util = require 'xlua.util'
xlua.private_accessible(CS.MallSkinGoodController)
xlua.private_accessible(CS.MallSkinDisplayListController)
xlua.private_accessible(CS.SkinMallDisplayItemController)

local RequestBuyGoodHandle_New = function(self, succeed)
	if succeed == false then
		return
	end

	self:RequestBuyGoodHandle(succeed)

	local skinDisplay = self:GetComponent(typeof(CS.SkinMallDisplayItemController))
    if skinDisplay ~= nil then
        --分类列表中“推荐项”有2份，都要刷新
        if CS.MallSkinDisplayListController.Instance ~= nil and self.good.isRec == true and skinDisplay.skinListType == CS.SkinDisplayListType.Overview then     
            local listHolders = CS.MallSkinDisplayListController.Instance.itemsController.currentHolders
        	for  i = 0, listHolders.Count -1 do
	            local label = listHolders[i].currentLabel
	            if label ~= nil then
	            	local itemC = label.transform:GetComponent(typeof(CS.SkinMallDisplayItemController))
		            if itemC ~= nil then
		            	itemC:UpdateState(skinDisplay.mallGoodIndex);
		            end
	            end	            
	        end
        end
	end
end


util.hotfix_ex(CS.MallSkinGoodController,'RequestBuyGoodHandle',RequestBuyGoodHandle_New)




