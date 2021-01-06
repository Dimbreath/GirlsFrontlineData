local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisSkillDescription)
local get_SpecialOPSController_MMissionInfoPanel = function(self)
	if self.mMissionInfoPanel == nil or self.mMissionInfoPanel:isNull() then
		self.mMissionInfoPanel = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("UGUIPrefabs/MissionSelection/MissionInfo"),self.transform);
	end
	return  self.mMissionInfoPanel;
end
util.hotfix_ex(CS.SpecialOPSController,'get_MMissionInfoPanel',get_SpecialOPSController_MMissionInfoPanel)