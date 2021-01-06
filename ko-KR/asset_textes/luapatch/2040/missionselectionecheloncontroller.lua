local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionEchelonController)
local InitAutoUI = function(self,...)
    self:InitAutoUI(...);
    if self.restartAutoMission then
        local iter = self.autoMissionTeamlist:GetEnumerator();
        while iter:MoveNext() do
            if CS.GameData.dictTeam[iter.Current]:Exists(function(g) return g.level == g.levelUpperLimit; end) then
                self.teamDisableText.text = CS.Data.GetLang(20076)..CS.Data.GetLang(20075);
                iter = nil;
                return;
            end
        end
        iter = nil;
    end
end
util.hotfix_ex(CS.MissionSelectionEchelonController, 'InitAutoUI', InitAutoUI)