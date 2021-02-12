local util = require 'xlua.util'
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

util.hotfix_ex(CS.SpecialMissionInfoController,'FinishAVG',FinishAVG)
