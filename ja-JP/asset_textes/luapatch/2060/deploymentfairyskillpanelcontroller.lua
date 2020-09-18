local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentFairySkillPanelController)

local UpdateAllFriendlyFloatingTeamInfo = function(self)
	self:UpdateAllFriendlyFloatingTeamInfo();
	for i=0,CS.DeploymentController.Instance.allyTeams.Count-1 do
		CS.DeploymentController.Instance.allyTeams[i]:RefeshBuffUI();
	end
end

local OnClickSwitchGlobalSkillAuto = function(self)
	self:OnClickSwitchGlobalSkillAuto();
	if self.currentFairy ~= nil then
		self.currentFairy.autoSkill = CS.ConfigData.autoFairySkill;
	end
end
util.hotfix_ex(CS.DeploymentFairySkillPanelController,'UpdateAllFriendlyFloatingTeamInfo',UpdateAllFriendlyFloatingTeamInfo)
util.hotfix_ex(CS.DeploymentFairySkillPanelController,'OnClickSwitchGlobalSkillAuto',OnClickSwitchGlobalSkillAuto)
