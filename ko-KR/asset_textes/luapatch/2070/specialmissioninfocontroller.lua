local util = require 'xlua.util'
local panelController = require("2070/OPSPanelController")
xlua.private_accessible(CS.SpecialMissionInfoController)
local FinishAVG = function(self)
	self:FinishAVG();
	if self.panelMission ~= nil and not self.panelMission:isNull() then
		self.panelMission:ShowNewTag();
	end
	if CS.OPSRuler.Instance ~= nil and not CS.OPSRuler.Instance:isNull() then
		CS.OPSRuler.Instance:InitRulerAvg();
	end
end

local ShowCurrentMission = function(self,missionId)
	self.mission = CS.GameData.listMission:GetDataById(missionId);
	ShowMissionPanel(CS.OPSPanelController.Instance,self.mission);
	CS.CommonAudioController.PlayUI("UI_selete_2");
end
util.hotfix_ex(CS.SpecialMissionInfoController,'FinishAVG',FinishAVG)
util.hotfix_ex(CS.SpecialMissionInfoController,'ShowCurrentMission',ShowCurrentMission)