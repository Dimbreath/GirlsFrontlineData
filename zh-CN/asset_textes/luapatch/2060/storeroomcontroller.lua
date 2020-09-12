local util = require 'xlua.util'
xlua.private_accessible(CS.StoreRoomController)
local SetActive = function(self,show)
	self:SetActive(show);
	self.sangvisButton.gameObject:SetActive(show and CS.GameFunctionSwitch.GetGameFunctionOpen('sangvis'));
end
util.hotfix_ex(CS.StoreRoomController,'SetActive',SetActive)