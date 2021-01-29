local util = require 'xlua.util'
xlua.private_accessible(CS.BattleSimulatorController)

local Init = function(self)
	if CS.GF.Battle.BattleController.renderTexture == nil then
		self:Init();
	end
end

util.hotfix_ex(CS.BattleSimulatorController,'Init',Init)
