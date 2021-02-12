local util = require 'xlua.util'
xlua.private_accessible(CS.Live2DModelController)

local InitModel_New = function(self,...)
	local res = self:InitModel(...)
	if res == true then
		self._accelHelper.useTest = true
	end
	return res
end

util.hotfix_ex(CS.Live2DModelController,'InitModel',InitModel_New)


