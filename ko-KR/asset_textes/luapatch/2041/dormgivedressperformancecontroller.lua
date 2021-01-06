local util = require 'xlua.util'
xlua.private_accessible(CS.DormGiveDressPerformanceController)


local DormGiveDressPerformanceController_Open = function(gunInfoId, skinId, giftId, callback) 
	if CS.FormationEffectItemController.Instance ~= nil then
    	CS.FormationEffectItemController.Instance.gameObject:SetActive(false);
    end
 	CS.DormGiveDressPerformanceController.Open(gunInfoId, skinId, giftId, callback);
end
util.hotfix_ex(CS.DormGiveDressPerformanceController,'Open',DormGiveDressPerformanceController_Open)