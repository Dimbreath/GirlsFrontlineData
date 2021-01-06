local util = require 'xlua.util'
xlua.private_accessible(CS.OPSConfig)
xlua.private_accessible(CS.UICoinBattleSetting)
local get_UseWinCounter = function(self)
    if self.winCount == 0 then
        return 0
    else
        return self.UseWinCounter
    end
end
local get_GetCoinParameter = function(self)
    if self._getcoin_parameter == nil then
        local arr = {}
        arr[1] = 0
        arr[2] = 0
        arr[3] = 0
        arr[4] = 0
        if not CS.System.String.IsNullOrEmpty(self.getcoin_parameter) and getcoin_parameter ~= "0" then
            local arrCount = 1
            string.gsub(self.getcoin_parameter,'[^,]+',function(s)
                if arrCount <= 4 then
                    arr[arrCount] = math.floor(tonumber(s) * 100)
                    arrCount = arrCount + 1
                end
            end)
            arrCount = nil
        end
        self._getcoin_parameter = arr;
        arr = nil
    end
    return self._getcoin_parameter
end
local CalculateCoinAfterBattle = function(self)
    local mission
    local result = 0
    for i=1,CS.GameData.listMission.Count do
        if CS.GameData.listMission:GetDataByIndex(i-1).missionInfo.id == CS.GameData.currentSelectedMissionInfo.id then
            mission = CS.GameData.listMission:GetDataByIndex(i-1)
            break
        end
    end
    local arrGetCoinParameter = mission.missionInfo.GetCoinParameter
    
    if mission.passTimeCount > 30 then
        result = math.floor(mission.missionInfo.getcoin * CS.Data.GetFloat("coin_get_failure_ratio"))
    else
        if mission.passTimeCount >= 10 then
            result = mission.missionInfo.getcoin + math.floor(arrGetCoinParameter[0] / 100 - arrGetCoinParameter[1] * mission.passTimeCount / 100)
        else
            result = mission.missionInfo.getcoin + math.floor(arrGetCoinParameter[2] / 100 - arrGetCoinParameter[3] * mission.passTimeCount / 100)
        end
    end
    mission = nil
    arrGetCoinParameter = nil
    return result
end
util.hotfix_ex(CS.Mission,'get_UseWinCounter',get_UseWinCounter)
xlua.hotfix(CS.MissionInfo,'get_GetCoinParameter',get_GetCoinParameter)
xlua.hotfix(CS.UICoinBattleSetting,'CalculateCoinAfterBattle',CalculateCoinAfterBattle)
