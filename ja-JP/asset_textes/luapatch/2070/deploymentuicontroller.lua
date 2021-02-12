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

util.hotfix_ex(CS.DeploymentUIController,'ShowLeftBuildSkillUI',ShowLeftBuildSkillUI)
util.hotfix_ex(CS.DeploymentUIController,'ShowRightBuildSkillUI',ShowRightBuildSkillUI)



