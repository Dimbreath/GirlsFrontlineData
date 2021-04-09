local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamController)

local Transfer = function(self,target)
	--target.spotAction:MoveHostageDataToSpotAction(self.currentSpot.spotAction);
	self:Transfer(target);
	CS.DeploymentController.TriggerSwitchAbovePanelEvent(true);
end

local TransferComplete = function(self)
	self:TransferComplete();
	CS.DeploymentController.TriggerRefreshUIEvent();
	if self.squadTeam ~= nil then
		if self.currentSpot.currentTeam ~= nil and self.currentSpot.currentTeamTemp ~= nil then
			self.currentSpot.currentTeamTemp = self.currentSpot.currentTeam;
			self.currentSpot.currentTeam = self;
		end
	end
end

local TransferBefore = function(self)
	self:TransferBefore();
	if self.last.buildControl ~= nil then
		self.last.buildControl:RefreshController();
	end
end
local Die = function(self)
	self:Die();
	if CS.DeploymentController.Instance.currentSelectedTeam ~= nil and not CS.DeploymentController.Instance.currentSelectedTeam:isNull() then
		print("重新计算当前技能")
		CS.DeploymentUIController.Instance:OnSelectTeamSkillUI(CS.DeploymentController.Instance.currentSelectedTeam);
	end
end

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

util.hotfix_ex(CS.DeploymentTeamController,'Transfer',Transfer)
util.hotfix_ex(CS.DeploymentTeamController,'TransferBefore',TransferBefore)
util.hotfix_ex(CS.DeploymentTeamController,'TransferComplete',TransferComplete)
util.hotfix_ex(CS.DeploymentTeamController,'Die',Die)
util.hotfix_ex(CS.DeploymentTeamController,'get_mat',matUse)