local util = require 'xlua.util'
xlua.private_accessible(CS.ParticleScaler)

local DeploymentInit = function(self)
	self:DeploymentInit();
	for i=0,self.transform.childCount-1 do
		self.transform:GetChild(i).gameObject:SetActive(true);
	end
end

util.hotfix_ex(CS.ParticleScaler,'DeploymentInit',DeploymentInit)

