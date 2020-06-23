local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionContainer)
xlua.private_accessible(CS.GameData)
local  OPSPanelMissionContainer_ShowTime =  function(self)
	self:ShowTime();
	local t = self.txtUnlockTime;
	t.text = CS.GameData.FormatLongToTimeStr(self.unclockTime - CS.GameData.GetCurrentTimeStamp(),true);
end
util.hotfix_ex(CS.OPSPanelMissionContainer,'ShowTime',OPSPanelMissionContainer_ShowTime)
