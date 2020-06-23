local util = require 'xlua.util'
xlua.private_accessible(CS.AVGTrigger)
local DeploymentController_InitEvent = function(self)
    self:DeploymentController_InitEvent()
    local currentMission = CS.GameData.listMission:GetDataById(CS.GameData.currentSelectedMissionInfo.id)
    if currentMission ~= nil and currentMission.missionInfo.avgInfo == nil then
        CS.DeploymentController.InitBGM()
    end
    currentMission = nil
end
util.hotfix_ex(CS.AVGTrigger,'DeploymentController_InitEvent',DeploymentController_InitEvent)