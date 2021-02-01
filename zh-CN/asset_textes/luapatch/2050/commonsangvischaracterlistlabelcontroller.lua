local util = require 'xlua.util'
xlua.private_accessible(CS.CommonSangvisCharacterListLabelController)
local _OnLoadGunStatusHandler = function(self,obj)
	if self.gunStatusController ~=nil then
		self.gunStatusController:Init(self.gun.status);
		return;
	end
	self:OnLoadGunStatusHandler(obj);
end
util.hotfix_ex(CS.CommonSangvisCharacterListLabelController,'OnLoadGunStatusHandler',_OnLoadGunStatusHandler)