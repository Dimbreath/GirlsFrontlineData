local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterDetailUIController)
local InitUIElements = function(self)
	self:InitUIElements()
	self.mImageDetailMask:GetComponent(typeof(CS.ExImage)).raycastTarget = true
end

util.hotfix_ex(CS.TheaterDetailUIController,'InitUIElements',InitUIElements)