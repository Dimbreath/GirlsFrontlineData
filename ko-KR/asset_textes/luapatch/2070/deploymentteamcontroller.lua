local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamController)

local matUse = function(self)
	if self._mat == nil then
		local mr = self.spineHolder:GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		self.spineHolder:GetComponent(typeof(CS.SkeletonAnimation)).onlyRefreshMaterialsOnStart = true;
		self._mat = mr.material;
		local matBuff = mr.materials;
		mr.sharedMaterials = matBuff;
	end
	return self._mat;
end

local freeBuffMre = function(self)
	return 0;
end

local freeBuffAmmo = function(self)
	return 0;
end

util.hotfix_ex(CS.DeploymentTeamController,'get_mat',matUse)
util.hotfix_ex(CS.DeploymentTeamController,'freeBuffMre',freeBuffMre)
util.hotfix_ex(CS.DeploymentTeamController,'freeBuffAmmo',freeBuffAmmo)