local util = require 'xlua.util'
xlua.private_accessible(CS.ImageBufferBlurRefraction)
local Awake = function(self)
	self:Awake();
	if CS.SpecialActivityController.Instance ~= nil and CS.ImageBufferBlurRefraction.depthonlyCamain ~= nil then
		CS.ImageBufferBlurRefraction.depthonlyCamain.nearClipPlane = -10;
	end
end

util.hotfix_ex(CS.ImageBufferBlurRefraction,'Awake',Awake)
