local util = require 'xlua.util'
xlua.private_accessible(CS.ParticleScaler)

local DeploymentInit = function(self)
	self:DeploymentInit();
	if self.useInDeployment then
		if self.delayTime == 0 then
			for i=0,self.transform.childCount-1 do
				self.transform:GetChild(i).gameObject:SetActive(true);
			end
		else
			for i=0,self.transform.childCount-1 do
				self.transform:GetChild(i).gameObject:SetActive(false);
			end	
		end
	end
end

util.hotfix_ex(CS.ParticleScaler,'DeploymentInit',DeploymentInit)


