local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionBase)
local ShowUnclockOther = function(self)
	self.lastmissioninfo = nil;
	self:ShowUnclockOther();
end

util.hotfix_ex(CS.OPSPanelMissionBase,'ShowUnclockOther',ShowUnclockOther)

