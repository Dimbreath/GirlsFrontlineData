local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildSkillItem)
xlua.private_accessible(CS.BuildingAction)
local icon;
local RefreshRightUI = function(self)
	self:RefreshRightUI();
	while self.imageIconBigRight.transform.childCount > 0 do
		CS.UnityEngine.Object.DestroyImmediate(self.imageIconBigRight.transform:GetChild(0).gameObject);
	end
	local builder = CS.CommonIconController.CommonIconControllerBuilder();	
	icon = builder:SetTipOrder(9):Build():GetComponent(typeof(CS.CommonIconController));
	icon.transform:SetParent(self.imageIconBigRight.transform, false);
	icon.strTitle = self.buildSkill.skill.name; 
	icon.strIntroduction = self.buildSkill.skill.description;
	while icon.transform.childCount > 0 do
		CS.UnityEngine.Object.DestroyImmediate(icon.transform:GetChild(0).gameObject);
	end
	--CS.EventTriggerListener.Get(self.imageIconBigRight.gameObject).onEnter -= ShowTip;
	--CS.EventTriggerListener.Get(self.imageIconBigRight.gameObject).onExit -= CloseTip;
	--CS.EventTriggerListener.Get(self.gameObject).onEnter = ShowTip;
	--CS.EventTriggerListener.Get(self.gameObject).onExit = CloseTip;
end

local Init = function(self)
	self:Init();
	if self.buildSkill.buildAction ~= nil and self.buildSkill.buildAction._buildController == nil then
		self.buildSkill.buildAction._buildController = CS.DeploymentBackgroundController.Instance.listBuildingController:Find(function(build)
		return build.buildAction == self.buildSkill.buildAction;
		end);
	end
end

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
util.hotfix_ex(CS.DeploymentBuildSkillItem,'RefreshRightUI',RefreshRightUI)
util.hotfix_ex(CS.DeploymentBuildSkillItem,'Init',Init)
util.hotfix_ex(CS.DeploymentBuildSkillItem,'RequestControlBuild',RequestControlBuild)
util.hotfix_ex(CS.DeploymentBuildSkillItem,'RequestBuffControlBuild',RequestBuffControlBuild)


