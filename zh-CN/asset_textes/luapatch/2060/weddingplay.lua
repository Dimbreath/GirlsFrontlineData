local util = require 'xlua.util'
xlua.private_accessible(CS.WeddingPlay)
local LoadGun = function(self)
	self:LoadGun();
	if self.isLoadLive2D then
		self.mCommonLive2DController:CloseHitAreaPlayMotionsMode();
	end
	if CS.GunStateController.Instance ~= nil and not CS.GunStateController.Instance:isNull() and CS.GunStateController.Instance.picController ~= nil and CS.GunStateController.Instance.picController.isLive2D then
		CS.GunStateController.Instance.picController:CloseHitAreaPlayMotionsMode();
	end
end
local FinalShow = function(self)
	self:FinalShow();
	if CS.GunStateController.Instance ~= nil and not CS.GunStateController.Instance:isNull() and CS.GunStateController.Instance.picController ~= nil and CS.GunStateController.Instance.picController.isLive2D then
		CS.GunStateController.Instance.picController:OpenHitAreaPlayMotionsMode();
	end
end
util.hotfix_ex(CS.WeddingPlay,'LoadGun',LoadGun)
util.hotfix_ex(CS.WeddingPlay,'FinalShow',FinalShow)