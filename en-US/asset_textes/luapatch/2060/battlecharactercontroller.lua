local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleCharacterController)
xlua.private_accessible(CS.GF.Battle.CSkillInstance)
local InitMemberOffset = function(self)
	if self:IsSummon() then
		local tempcamp = self.camp
		self.camp = CS.GF.Battle.Camp.neutral
		self:InitMemberOffset()
		self.camp = tempcamp
	else
		self:InitMemberOffset()
	end
	
end
util.hotfix_ex(CS.GF.Battle.BattleCharacterController,'InitMemberOffset',InitMemberOffset)