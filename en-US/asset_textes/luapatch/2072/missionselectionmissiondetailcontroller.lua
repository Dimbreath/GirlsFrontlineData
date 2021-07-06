local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionMissionDetailController)

local InitUIElements = function(self)
	self:InitUIElements();
	print("missioninfo");
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		CS.UnityEngine.Object.Destroy(self.transform:Find("UI/Groove/Bg").gameObject);
		local objNew = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Prefabs/MissionInfo_Bg"), self.transform:Find("UI/Groove"));
		objNew.name = "Bg";
		objNew.transform:SetAsFirstSibling();
		objNew = nil;
	end
end
util.hotfix_ex(CS.MissionSelectionMissionDetailController,'InitUIElements',InitUIElements)