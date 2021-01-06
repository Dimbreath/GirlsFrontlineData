local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.gsEffect)

local InitData = function(self,existDuration,parent)
	local tracingTarget = self.mTarget
	if tracingTarget ~= nil and tracingTarget:IsDead() and tracingTarget:GetMemberCount() > 0 then
		self.mTarget = tracingTarget:GetMemberImpl(CS.GF.Battle.BRandom.Range(0, tracingTarget:GetMemberCount() - 1))	
	end
	self:InitData(existDuration,parent)
end
util.hotfix_ex(CS.GF.Battle.gsEffect,'InitData',InitData)

