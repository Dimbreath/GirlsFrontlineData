local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchSkillChoosePanle)
local myInitSkillInfo = function(self,skillType)
	self:InitSkillInfo(skillType);
	local skill = self.gun:GetSkill(skillType);
	if skill.toNextLevelTrainTime ~= 0 then
		self.imageFinishResearchImmiately:GetComponent(typeof(CS.UnityEngine.UI.Button)).interactable = true;
    else
		self.imageFinishResearchImmiately:GetComponent(typeof(CS.UnityEngine.UI.Button)).interactable = false;
	end
end
util.hotfix_ex(CS.ResearchSkillChoosePanle,'InitSkillInfo',myInitSkillInfo) 