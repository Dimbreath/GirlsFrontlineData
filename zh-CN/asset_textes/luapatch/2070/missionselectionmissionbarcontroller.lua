local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionMissionBarController)

local ShowDrawEventIcon = function(self)
	if self.parent == nil then
		return;
	end
	self:ShowDrawEventIcon();
end

util.hotfix_ex(CS.MissionSelectionMissionBarController,'ShowDrawEventIcon',ShowDrawEventIcon)