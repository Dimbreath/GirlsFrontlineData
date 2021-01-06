local util = require 'xlua.util'
xlua.private_accessible(CS.MobileShadow)
local Init = function(self)
	self._shadowEdgeFadeMaterial = nil
	self._shadowCameraGO = nil
	self:Init();
end
util.hotfix_ex(CS.MobileShadow,"Init",Init)