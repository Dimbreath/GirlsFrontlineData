local util = require 'xlua.util'
xlua.private_accessible(CS.HomeAdjutantController)

local UpdateHomeAdjutant_New = function(self, playLogin)
	self.currFetterDialogue = nil
	self:UpdateHomeAdjutant(playLogin)
end

util.hotfix_ex(CS.HomeAdjutantController,'UpdateHomeAdjutant',UpdateHomeAdjutant_New)