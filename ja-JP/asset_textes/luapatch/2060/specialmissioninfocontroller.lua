local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialMissionInfoController)
local RequestAbortAutoMissionActionHandle = function(self,result)
	self:RequestAbortAutoMissionActionHandle(result);
	CS.CommonTopController.TriggerRefershResourceEvent();
end
util.hotfix_ex(CS.SpecialMissionInfoController,'RequestAbortAutoMissionActionHandle',RequestAbortAutoMissionActionHandle)