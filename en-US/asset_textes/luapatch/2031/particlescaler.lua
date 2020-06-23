local util = require 'xlua.util'
xlua.private_accessible(CS.ParticleScaler)
local Awake = function(self)
	self:Awake();
	if CS.DeploymentController.Instance ~= nil then
		self.setSize = 0.5;
	end
end
util.hotfix_ex(CS.ParticleScaler,'Awake',Awake)