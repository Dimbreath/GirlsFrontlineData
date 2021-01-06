local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.Gun)
local UpdateMemberAmount = function(self)
	self:UpdateMemberAmount()
	if self.life > 0 and self.member == 0 then
		self.member = 1
	end
end
util.hotfix_ex(CS.GF.Battle.Gun,'UpdateMemberAmount',UpdateMemberAmount)