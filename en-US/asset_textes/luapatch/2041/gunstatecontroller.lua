local util = require 'xlua.util'
xlua.private_accessible(CS.GunStateController)

local LoadGunStateBackground = function(self)
	self:LoadGunStateBackground();
	if self.gun ~= nil then
		print(self.gun.info.gunCamps);
	elseif self.gunInfo ~= nil then
		print(self.gunInfo.gunCamps);
	end
end
util.hotfix_ex(CS.GunStateController,'LoadGunStateBackground',LoadGunStateBackground)