local util = require 'xlua.util'
xlua.private_accessible(CS.ReinforcementConfirmBoxController)
local ReinforcementConfirmBoxController_CheckExistExplorGun = function(self)
	 if CS.ReinforcementController.Instance ~= nil then
	 	return self:CheckExistExplorGun(); 
	 else
	 	return false;
	 end
end
util.hotfix_ex(CS.ReinforcementConfirmBoxController,'CheckExistExplorGun',ReinforcementConfirmBoxController_CheckExistExplorGun)
