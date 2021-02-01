local util = require 'xlua.util'
xlua.private_accessible(CS.FriendChangeIntroController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.transform.localScale = CS.UnityEngine.Vector3(1,1,1);
end
util.hotfix_ex(CS.FriendChangeIntroController,'InitUIElements',InitUIElements)