local util = require 'xlua.util'
xlua.private_accessible(CS.CommonSimulatorSettlementController)
local OnPointerClick = function(self,eventData)
	if self.isAutoMission then
		local cacheMission = CS.GameData.currentSelectedMissionInfo
		CS.GameData.currentSelectedMissionInfo = nil
	end
    self:OnPointerClick(eventData);
    print('OnPointerClick')
    if self.isAutoMission then
		CS.GameData.currentSelectedMissionInfo = cacheMission
		cacheMission = nil
	end
    
end
util.hotfix_ex(CS.CommonSimulatorSettlementController,'OnPointerClick',OnPointerClick)