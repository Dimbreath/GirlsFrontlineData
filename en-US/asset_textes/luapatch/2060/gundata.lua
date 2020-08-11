local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.Gun)
local get_forceManualSkill = function(self)
	return not self.forceManualSkill
end
util.hotfix_ex(CS.GF.Battle.Gun,'get_forceManualSkill',get_forceManualSkill)