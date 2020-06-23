local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleFairyController)
local SetFariy = function(self,fairy)
	if fairy ~= nil then
		fairy.waitForConsume = false;
	end
	self:SetFariy(fairy);
end
util.hotfix_ex(CS.GF.Battle.BattleFairyController,'SetFariy',SetFariy)