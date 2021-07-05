local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamController)

local freeBuffMre = function(self)
	return 0;
end

local freeBuffAmmo = function(self)
	return 0;
end

util.hotfix_ex(CS.DeploymentTeamController,'freeBuffMre',freeBuffMre)
util.hotfix_ex(CS.DeploymentTeamController,'freeBuffAmmo',freeBuffAmmo)