local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterBattleTeamSelectionUIController)
xlua.private_accessible(CS.RequestTheaterAreaConfirm)
local EnterBattle = function(self)
    if CS.GameData.mTheaterExerciseAction.nextIsBoss then
        CS.GameData.mTheaterExerciseAction.theater_squads_use_count:Clear()
    end
    self:EnterBattle()
end

local RequestTheaterAreaConfirm_SuccessHandleData = function(self,www)
    self:SuccessHandleData(www);
    CS.GameData.mTheaterExerciseAction.theater_squads = self.squadIds;
end
local GetTeam = function(self,teamId)
    local team = self:GetTeam(teamId);
    if team == nil then
        team = CS.GF.Battle.Team();
    end
    return team;
end
local CreateTeamList = function(self)
    util.hotfix_ex(CS.TheaterTeamData,'GetTeam',GetTeam);
    self:CreateTeamList();
    xlua.hotfix(CS.TheaterTeamData,'GetTeam',nil);
end
util.hotfix_ex(CS.TheaterBattleTeamSelectionUIController,'EnterBattle',EnterBattle)
util.hotfix_ex(CS.RequestTheaterAreaConfirm,'SuccessHandleData',RequestTheaterAreaConfirm_SuccessHandleData)
util.hotfix_ex(CS.TheaterBattleTeamSelectionUIController,'CreateTeamList',CreateTeamList)