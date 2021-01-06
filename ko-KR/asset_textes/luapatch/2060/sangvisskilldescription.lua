local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisSkillDescription)
local InitSangvisSkill = function(self,...)
	self:InitSangvisSkill(...)
	local skill = self.sangvisGun:GetSangvisGunSkillInfo(self.skillInfo.skillIndex)
	if skill.IsInitiativeSkill and self.skillInfo.isUnlock then
		local curskill = self.sangvisGun:GetSkill(self.sangvisGun.forceManualSkillMark)
		if curskill ~= nil and curskill.info ~=nil then
			local forceskill = (curskill.info.is_manual ~= 0)
			local gunforce = self.sangvisGun.forceManualSkill
			if (forceskill and not gunforce) or (not forceskill and gunforce) then
				self:UpdateForceManualUI(true)
				else
				self:UpdateForceManualUI(false)
			end
		end
	end
end
util.hotfix_ex(CS.SangvisSkillDescription,'InitSangvisSkill',InitSangvisSkill)