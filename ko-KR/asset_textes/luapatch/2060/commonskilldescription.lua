local util = require 'xlua.util'
xlua.private_accessible(CS.CommonSkillDescription)
local Init = function(self,...)
	self:Init(...)
	local skill = self.gun:GetSkill(self.skillNum)
	if skill.info ~= null and skill.info.code ~= null then
		if not self.isIllus and skill.info.type == 1 then
			local forceskill = (skill.info.is_manual ~= 0)
			local gunforce = self.gun.forceManualSkill
			if (forceskill and not gunforce) or (not forceskill and gunforce) then
				gunforce = true
			else
				gunforce = false
			end
			self:UpdateForceManualUI(gunforce)
		end
	end
end
util.hotfix_ex(CS.CommonSkillDescription,'Init',Init)