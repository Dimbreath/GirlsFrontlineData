local util = require 'xlua.util'
local panelController = require("2070/OPSPanelController")
xlua.private_accessible(CS.OPSPanelProcessItem)

local RefreshUI = function(self)
	print(self.info.diffcluty);
	if self.info.diffcluty == -1 then
		local txtName = self.transform:Find("Mission/RollingText/Tex_Mission"):GetComponent(typeof(CS.ExText));
		txtName.text = self.info.mission.missionInfo.name;
		self.transform:Find("Mission/Img_MissionBattleType").gameObject:SetActive(self.info.mission.missionInfo.specialType ~= CS.MapSpecialType.Story);
		self.transform:Find("Mission/Img_MissionStoryType").gameObject:SetActive(self.info.mission.missionInfo.specialType == CS.MapSpecialType.Story);
		self.transform:Find("Mission/Img_New").gameObject:SetActive(self.info.mission.counter == 0);
		return;
	end
	self:RefreshUI();
end
util.hotfix_ex(CS.OPSPanelProcessItem,'RefreshUI',RefreshUI)
