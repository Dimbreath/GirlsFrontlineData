local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionController)
local SwitchToCombatMission = function(self,button)
    self.currentMissionType = CS.MissionType.normal;
    self:SwitchToCombatMission(button);
end
util.hotfix_ex(CS.MissionSelectionController,'SwitchToCombatMission',SwitchToCombatMission)