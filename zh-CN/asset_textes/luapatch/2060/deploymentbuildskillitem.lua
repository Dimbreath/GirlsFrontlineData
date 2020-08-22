local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildSkillItem)

local CheckLayer = function()
	print("final");
	CS.DeploymentUIController.Instance:CheckLayer();
	CS.DeploymentController.Instance:AddAndPlayPerformance(nil);
end

local RequestControlBuild = function(self,data)
	local layer = CS.DeploymentBackgroundController.currentlayer;
	for i = 0,CS.DeploymentBackgroundController.layers.Count-1 do
		if CS.DeploymentBackgroundController.layers[i] ~= layer then
			CS.DeploymentBackgroundController.currentlayer = CS.DeploymentBackgroundController.layers[i];
			CS.DeploymentController.Instance:PlaySpotTransChange();
			CS.DeploymentController.Instance:PlayChangAllyTeam();
			CS.DeploymentController.Instance:PlayCameraBuildChange();
		end
	end
	CS.DeploymentBackgroundController.currentlayer = layer;
	self:RequestControlBuild(data);
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckLayer);
end

local RequestBuffControlBuild = function(self,data)
	local layer = CS.DeploymentBackgroundController.currentlayer;
	for i = 0,CS.DeploymentBackgroundController.layers.Count-1 do
		if CS.DeploymentBackgroundController.layers[i] ~= layer then
			CS.DeploymentBackgroundController.currentlayer = CS.DeploymentBackgroundController.layers[i];
			CS.DeploymentController.Instance:PlaySpotTransChange();
			CS.DeploymentController.Instance:PlayChangAllyTeam();
			CS.DeploymentController.Instance:PlayCameraBuildChange();
		end
	end
	CS.DeploymentBackgroundController.currentlayer = layer;
	self:RequestBuffControlBuild(data);	
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckLayer);
end
util.hotfix_ex(CS.DeploymentBuildSkillItem,'RequestControlBuild',RequestControlBuild)
util.hotfix_ex(CS.DeploymentBuildSkillItem,'RequestBuffControlBuild',RequestBuffControlBuild)