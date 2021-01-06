local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisFilterTypeChooseItemController)

local InitUIElements = function(self)
	self:Start();
	if CS.IllustratedBookEnemyListController.Instance ~=nil then
		if self.itemType == CS.SangvisFilterTypeChooseItemController.FilterItemType.tag then
			self.itemType=CS.SangvisFilterTypeChooseItemController.FilterItemType.enemyType;
		elseif self.itemType==CS.SangvisFilterTypeChooseItemController.FilterItemType.shining and self.currentTag>0 then
			self.itemType=CS.SangvisFilterTypeChooseItemController.FilterItemType.tag;
		end
	elseif CS.CommonSangvisCharacterListController.Instance ~=nil then	
		if self.itemType == CS.SangvisFilterTypeChooseItemController.FilterItemType.shining and self.currentTag>0 then
			self.itemType=CS.SangvisFilterTypeChooseItemController.FilterItemType.tag;
		end
	end 
end
util.hotfix_ex(CS.SangvisFilterTypeChooseItemController,'Start',InitUIElements)