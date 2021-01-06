local util = require 'xlua.util'
xlua.private_accessible(CS.MallController)

local myOnClickShowShop = function(self, tag)
    self:OnClickShowShop(tag);
	if (tag == true) then
		self:OnClickGiftPackage();
		self:ChangeLeftButtonImage("Gift")
		if(CS.GameData.kalinaFavorInfo.currentFavorRestClickNum > 0) then
			self.kalinLoveItem.gameObject:SetActive(true);
		else
			self.kalinLoveItem.gameObject:SetActive(false);
		end
	end
end
local myStart = function(self)
    self:Start()
	self:OpenChangeClothByJumpType();
end
util.hotfix_ex(CS.MallController,'OnClickShowShop',myOnClickShowShop)
util.hotfix_ex(CS.MallController,'Start',myStart)