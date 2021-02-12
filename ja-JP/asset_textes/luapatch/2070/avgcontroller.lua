local util = require 'xlua.util'
xlua.private_accessible(CS.AVGController)

local InvokeSpark = function(self)
	self:InvokeSpark();
	local ps = self.goParticleSpark:GetComponent(typeof(CS.UnityEngine.ParticleSystem));
	local main = ps.main;
	main.scalingMode = CS.UnityEngine.ParticleSystemScalingMode.Hierarchy;
	main = nil;
	ps = nil;
	self.goParticleSpark.transform.anchoredPosition = CS.UnityEngine.Vector2(-1200,-800);
end

util.hotfix_ex(CS.AVGController,'InvokeSpark',InvokeSpark)
