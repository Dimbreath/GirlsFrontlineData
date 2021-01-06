local util = require 'xlua.util'
xlua.private_accessible(CS.GunStateController)

local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find('Frame').localPosition = CS.UnityEngine.Vector3(0,0,30);
end
util.hotfix_ex(CS.GunStateController,'InitUIElements',InitUIElements)