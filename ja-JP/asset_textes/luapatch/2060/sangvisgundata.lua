local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisGun)
local get_forceManualSkill = function(self)
	local skill = self:GetSkill(self.forceManualSkillMark)
	local boolflag = false
	if skill.info.is_manual == 1 then
		boolflag = true
	end
	if self.forceManualSkill == boolflag then
		return false
	else
		return true
	end
end
util.hotfix_ex(CS.SangvisGun,'get_forceManualSkill',get_forceManualSkill)