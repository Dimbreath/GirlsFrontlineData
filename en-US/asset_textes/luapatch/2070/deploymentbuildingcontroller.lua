local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingController)
xlua.private_accessible(CS.BuildingAction)
local otherMeshRenders;
local InitCode = function(self,code)
	self:InitCode(code);
	if self.buildObj ~= nil and not self.buildObj:isNull() then
		otherMeshRenders = self.buildObj:GetComponentsInChildren(typeof(CS.UnityEngine.MeshRenderer));
		for i=0,otherMeshRenders.Length-1 do
			otherMeshRenders[i].material.shader = self.Mat.shader;
		end
	end
end

local CheckControlUI  = function(self,teamcontroller)
	local skills = self:CheckControlUI(teamcontroller);
	for i=0,skills.Count-1 do
		skills[i].teamControler = teamcontroller;
	end
	return skills;
end

local Init = function(self)
	if CS.GameData.missionAction ~= nil then
		local buildAction = CS.GameData.missionAction.listBuildingAction:GetDataById(self.spot.spotInfo.id);
		buildAction._buildController = self;
	end
	self.buildAction._buildController = self;
	--print(self.buildAction._buildController);
	self:Init();
	self.lastPercent = 0;
end

util.hotfix_ex(CS.DeploymentBuildingController,'InitCode',InitCode)
util.hotfix_ex(CS.DeploymentBuildingController,'CheckControlUI',CheckControlUI)
util.hotfix_ex(CS.DeploymentBuildingController,'Init',Init)

