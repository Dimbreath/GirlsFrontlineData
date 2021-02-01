local util = require 'xlua.util'
xlua.private_accessible(CS.WebCameraManager)

local WebCameraManager_OnClickClose = function(self)
	if self.gunLive2D ~=nil then
		self.gunLive2D.canHitAreaPlayMotions = true;
	end
	self:OnClickClose();
end
util.hotfix_ex(CS.WebCameraManager,'OnClickClose',WebCameraManager_OnClickClose)