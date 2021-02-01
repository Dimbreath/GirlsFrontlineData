local util = require 'xlua.util'
xlua.private_accessible(CS.MallGoodController)

local Init = function(self,...)
	self:Init(...)	
	if self.good.type == CS.GoodType.gemToBp then
		self.textTitle.text = self.textTitle.text.."x <color=#ffb400>3</color>"
		self:SetDailyQuota("10")
	end
end
util.hotfix_ex(CS.MallGoodController,'Init',Init)