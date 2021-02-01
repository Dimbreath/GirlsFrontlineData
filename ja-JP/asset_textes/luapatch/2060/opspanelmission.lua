local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMission)

local Init = function(self)
	if self.currentMission ~= nil and CS.OPSPanelController.Instance.campaionId == -31 then
		self.currentMission.Drop_item_Mullt:Clear();
	end
	self:Init();
end

util.hotfix_ex(CS.OPSPanelMission,'Init',Init)