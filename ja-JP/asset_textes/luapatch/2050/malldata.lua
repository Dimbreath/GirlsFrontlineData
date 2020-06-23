local util = require 'xlua.util'
xlua.private_accessible(CS.MallGood)
local RequestBuyGoodHandle = function(self,...)
	local buyNum = self.buyNum
	self:RequestBuyGoodHandle(...)
	if self.type == CS.GoodType.gemToBp then
		self.restNumber =self.restNumber + buyNum
	end
end
util.hotfix_ex(CS.MallGood,'RequestBuyGoodHandle',RequestBuyGoodHandle)