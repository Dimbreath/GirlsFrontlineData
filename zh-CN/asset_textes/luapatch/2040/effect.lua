local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.gsEffect)

local InitData = function(self,existDuration,parent)
	if self.mEffectCfg.creation_type == 3 then
		self.mTriggerCbFunc = nil
		--print("DmkFix")
	end
	self:InitData(existDuration,parent)
end
util.hotfix_ex(CS.GF.Battle.gsEffect,'InitData',InitData)