local util = require 'xlua.util'
xlua.private_accessible(CS.MallGoodController)
local Init = function(self,good,iconCode,iconDesc)
	if iconCode ~= nil or iconDesc ~= nil then
		self:Init(good,iconCode,iconDesc)
	else
		self:Init(good)
		self.textOriginalPrice.transform:SetSiblingIndex(1)
		self.textOriginalPrice.rectTransform.anchoredPosition = CS.UnityEngine.Vector2(231.4, -32.1)
	end
end

util.hotfix_ex(CS.MallGoodController,'Init',Init)