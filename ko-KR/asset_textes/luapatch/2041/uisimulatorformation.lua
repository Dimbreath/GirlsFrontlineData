local util = require 'xlua.util'
xlua.private_accessible(CS.UISimulatorFormation)
local Start = function(self)
	self:Start();
	if CS.UISimulatorFormation.theaterTeamId == 0 then
		CS.FormationFairyLabelController.Instance:Init(nil,-1);
	end
end
util.hotfix_ex(CS.UISimulatorFormation,'Start', Start);
