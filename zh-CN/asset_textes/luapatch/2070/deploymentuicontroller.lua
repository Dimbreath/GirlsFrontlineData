local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentUIController)

local ShowLeftBuildSkillUI = function(self)
	if self.leftSkills.Count == 0 then
		self:CloseLeftBuildControlUI();
	end
	self:ShowLeftBuildSkillUI();
end

local ShowRightBuildSkillUI = function(self)
	if self.buildSkillUIRight.Count == 0 then
		self:CloseRightBuildControlUI();
	end
	self:ShowRightBuildSkillUI();
end

local ShowDeploymentExplain = function(self)
	self:ShowDeploymentExplain();
	self:RefreshUI();
end

local CheckTypeComplete = function(winTypeInfo,showTarget,process,medal)
	if showTarget and not CS.DeploymentUIController.checkwintypeids:Contains(winTypeInfo.id) then
		CS.DeploymentUIController.checkwintypeids:Add(winTypeInfo.id);
	end
	local result,process = CS.DeploymentUIController.CheckTypeComplete(winTypeInfo,showTarget,process,medal);
	return result,process;
end

local RefreshUI = function(self)
	self:RefreshUI();
	if CS.GameData.missionAction ~= nil then
		local num = CS.GameData.missionAction.enemyDieNumber + CS.GameData.missionAction.alldieallyNum;
		self.textDeadRestEnemyCount.text = tostring(num);
	end
end
util.hotfix_ex(CS.DeploymentUIController,'ShowLeftBuildSkillUI',ShowLeftBuildSkillUI)
util.hotfix_ex(CS.DeploymentUIController,'ShowRightBuildSkillUI',ShowRightBuildSkillUI)
util.hotfix_ex(CS.DeploymentUIController,'ShowDeploymentExplain',ShowDeploymentExplain)
util.hotfix_ex(CS.DeploymentUIController,'CheckTypeComplete',CheckTypeComplete)
util.hotfix_ex(CS.DeploymentUIController,'RefreshUI',RefreshUI)



