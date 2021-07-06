local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialMissionInfoController)

local InitUIElements = function(self)
	self:InitUIElements();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		CS.UnityEngine.Object.Destroy(self.transform:Find("Groove/BossList/Bg").gameObject);
		local objNew = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Prefabs/OPSMissionInfo_Bg"), self.transform:Find("Groove/BossList"));
		objNew.name = "Bg";
		objNew.transform:SetSiblingIndex(1);
		objNew = nil;
	end
end
util.hotfix_ex(CS.SpecialMissionInfoController,'InitUIElements',InitUIElements)