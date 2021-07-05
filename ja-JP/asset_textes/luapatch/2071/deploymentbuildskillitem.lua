local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildSkillItem)

local RequestControlBuild = function(self,data)
	self:RequestControlBuild(data);
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
		local spot = CS.DeploymentBackgroundController.Instance.listSpot[i];
		spot:Checkroute();
	end
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
		local spot = CS.DeploymentBackgroundController.Instance.listSpot[i];
		spot:CheckPathLine(true);
	end
end

local RequestBuffControlBuild = function(self,data)
	self:RequestBuffControlBuild(data);
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
		local spot = CS.DeploymentBackgroundController.Instance.listSpot[i];
		spot:Checkroute();
	end
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
		local spot = CS.DeploymentBackgroundController.Instance.listSpot[i];
		spot:CheckPathLine(true);
	end
end

util.hotfix_ex(CS.DeploymentBuildSkillItem,'RequestControlBuild',RequestControlBuild)
util.hotfix_ex(CS.DeploymentBuildSkillItem,'RequestBuffControlBuild',RequestBuffControlBuild)


