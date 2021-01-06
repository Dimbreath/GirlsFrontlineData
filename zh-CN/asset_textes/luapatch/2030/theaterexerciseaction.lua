local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterExerciseAction)

TheaterExerciseAction_missionInfo = function(self)
    local missionInfo = self.missionInfo;
    if missionInfo.specialType == CS.MapSpecialType.Night then
        CS.DeploymentController.isNight = true
    end
    return missionInfo;
end

util.hotfix_ex(CS.TheaterExerciseAction,'get_missionInfo',TheaterExerciseAction_missionInfo)