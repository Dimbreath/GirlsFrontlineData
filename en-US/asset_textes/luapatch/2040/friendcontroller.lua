local util = require 'xlua.util'
xlua.private_accessible(CS.FriendController)

local FriendController_CloseAllPanel = function(self)
	self:CloseAllPanel();
	if self.goNill ~=nil and self.goNill.gameObject.activeSelf then	
		self.goNill.gameObject:SetActive(false);
	end
end
util.hotfix_ex(CS.FriendController,'CloseAllPanel',FriendController_CloseAllPanel)