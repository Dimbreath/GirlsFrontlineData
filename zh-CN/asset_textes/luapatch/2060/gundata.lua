local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.Gun)
local get_forceManualSkill = function(self)
	local skill = self:GetSkill(1)
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
local CheckFetterSkill = function(self)
	local tempID = self.teamId
	if tempID >= 0 then
		self.teamId = -1
		self.team = CS.GF.Battle.BattleController.Instance.listFriendlyGun
		self:CheckFetterSkill()
		self.teamId = tempID
	else
		self:CheckFetterSkill()
	end
end
util.hotfix_ex(CS.GF.Battle.Gun,'get_forceManualSkill',get_forceManualSkill)
util.hotfix_ex(CS.GF.Battle.Gun,'CheckFetterSkill',CheckFetterSkill)