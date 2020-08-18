local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionBase)

local PlayShow = function(self)
	self.currentMission = nil;
	self:RefreshUI();
	if self.holder.allowShow then
		--print(self.holder.allowShow);
		self:ActiveTween(true);
	end
end

util.hotfix_ex(CS.OPSPanelMissionBase,'PlayShow',PlayShow)