xlua.private_accessible(CS.OPSPanelMissionHolder)
local PlayLabel1 = function(self)
    CS.OPSPanelMissionHolder.maxX = CS.Mathf.Max(self.transform.localPosition.x, CS.OPSPanelMissionHolder.maxX)
    if CS.OPSPanelBackGround.Instance.CanClick then
        CS.OPSPanelBackGround.Instance:Move(CS.UnityEngine.Vector2(CS.OPSPanelMissionHolder.maxX+1000,self.transform.localPosition.y),true,0.2,0,true,0.6)
    end
    self.canshow = true
    self:Show()
    self.currentLabel:PlayShow()
end
local get_Clear = function(self)
    local mission
    for i=0,self.missionIds.Length-1 do
        mission = CS.GameData.listMission:GetDataById(self.missionIds[i]);
        if mission ~= nil and mission.missionInfo.specialType ~= CS.MapSpecialType.Story and mission.eventprize ~= null and mission.UseWinCounter >= mission.eventprize.bossHpBars then
            mission = nil
            return true
        end
        if mission ~= nil and mission.missionInfo.specialType == CS.MapSpecialType.Story and mission.winCount > 0 then
            mission = nil
            return true
        end
        if mission ~= nil and mission.missionInfo.isEndless and not mission.clocked then
            mission = nil
            return true
        end
    end
    mission = nil
    return false
end
xlua.hotfix(CS.OPSPanelMissionHolder,'PlayLabel1',PlayLabel1)
xlua.hotfix(CS.OPSPanelMissionHolder,'get_Clear',get_Clear)