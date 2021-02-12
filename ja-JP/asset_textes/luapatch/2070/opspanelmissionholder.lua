local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionHolder)
local PlayMove = function(self)
	self:PlayMove();
	self:ShowLable();
	self.currentLabel.lastmissioninfo = nil;
	self.currentLabel:PlayShow();
end

util.hotfix_ex(CS.OPSPanelMissionHolder,'PlayMove',PlayMove)

