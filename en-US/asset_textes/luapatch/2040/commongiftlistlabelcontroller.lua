local util = require 'xlua.util'
xlua.private_accessible(CS.CommonGiftListLabelController)
local myRequestGiveFairyGiftHandler = function(self,request)
    CS.FairyStateController.Instance.fairy = request.fairy;
	CS.FairyStateController.Instance:FairyStatistics();
	if(CS.CommonFairyListController.existInstance) then
		CS.CommonFairyListController.instance.gameObject:SetActive(false);
		CS.CommonFairyListController.instance:OnClickRest();
	end
	if (CS.ResearchFairyStrengthenController.Instance ~= nil and CS.ResearchFairyStrengthenController.Instance.mainFairy.id == request.fairy.id) then
		CS.ResearchFairyStrengthenController.Instance:OnSelectedStrengthenFairy(request.fairy);
	end
	if (CS.ResearchFairyCalibrationController.Instance ~= nil and CS.ResearchFairyCalibrationController.Instance.currentFairy.id == request.fairy.id) then
		CS.ResearchFairyCalibrationController.Instance.OnSelectedCalibrationFairy(request.fairy);
	end
end
util.hotfix_ex(CS.CommonGiftListLabelController,'RequestGiveFairyGiftHandler',myRequestGiveFairyGiftHandler)