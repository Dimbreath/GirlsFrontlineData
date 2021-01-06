local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainRecordData)

local GetTotalTakeDamagePercent = function(self)
	
	if self.totalTakeDamagePercentNumber ~= 0 then
		self.totalTakeDamagePercent = self.totalTakeDamagePercent * 100
	end
	local ans = self:GetTotalTakeDamagePercent()
	if self.totalTakeDamagePercentNumber ~= 0 then
		self.totalTakeDamagePercent = self.totalTakeDamagePercent / 100
	end
	return ans
end
util.hotfix_ex(CS.TargetTrainRecordData,'GetTotalTakeDamagePercent',GetTotalTakeDamagePercent)