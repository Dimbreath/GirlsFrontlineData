local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local OPSPanelController_RefreshItemNum = function(self)
	self:RefreshItemNum();
	if self.itemuiObj ~= nil then
		self.itemuiObj:SetActive(false);
	end
end

local LoadMissionInfo = function(obj)
	CS.OPSPanelController.Instance.missionInfoController = CS.UnityEngine.Object.Instantiate(obj):GetComponent(typeof(CS.SpecialMissionInfoController));
	CS.OPSPanelController.Instance.missionInfoController.transform:SetParent(CS.OPSPanelController.Instance.transform, false);
	CS.OPSPanelController.Instance.missionInfoController.gameObject:SetActive(false);
end

local OPSPanelController_Start = function(self)
	self:Start();
	CS.ResManager.GetObjectByPathAsync(LoadMissionInfo, "UGUIPrefabs/SpecialOPS/OPSMissionInfo");
end

util.hotfix_ex(CS.OPSPanelController,'RefreshItemNum',OPSPanelController_RefreshItemNum)
--util.hotfix_ex(CS.OPSPanelController,'Start',OPSPanelController_Start)
