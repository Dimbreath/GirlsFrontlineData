local util = require 'xlua.util'
xlua.private_accessible(CS.FormationController)
local myFormationReturControl = function(self,cancel)
    if CS.CommonEquipmentListController.inst ~= nil and CS.CommonEquipmentListController.inst.equipGroupImg.color ~= CS.UnityEngine.Color.white then
            CS.CommonEquipmentListController.inst:ShowEquipGroupPanel(false);     
	end
    self:FormationReturControl(cancel)
end
util.hotfix_ex(CS.FormationController,'FormationReturControl',myFormationReturControl)