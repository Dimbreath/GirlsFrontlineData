local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBackgroundController)
local DeploymentBackgroundController_OnLevelLoaded = function(self,scence,mod)
	if(CS.UnityEngine.Application.loadedLevelName == "Login") then
		CS.UnityEngine.Object.DestroyImmediate(self.gameObject);
	else
		self:OnLevelLoaded(scence,mod);
	end
end

local DeploymentBackgroundController_Start = function(self)
	self:Start();
	self.transform:Find("CanvasMap/Map/Quad").gameObject:AddComponent(typeof(CS.RendererOrder)).sortingLayer = "Background";
end

local DeploymentBackgroundController_Init = function(self)
	self:Init();
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count -1 do
		CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i).show = false;		
	end
end

util.hotfix_ex(CS.DeploymentBackgroundController,'OnLevelLoaded',DeploymentBackgroundController_OnLevelLoaded)
util.hotfix_ex(CS.DeploymentBackgroundController,'Start',DeploymentBackgroundController_Start)
util.hotfix_ex(CS.DeploymentBackgroundController,'Init',DeploymentBackgroundController_Init)