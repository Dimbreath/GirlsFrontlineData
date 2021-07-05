local util = require 'xlua.util'
xlua.private_accessible(CS.AVGTrigger)

local ScriptEndName = function(self,script)
	self.scriptName = script;
	local play = self:PlayAVG();
	if not play and CS.GameData.missionResult == nil then
		CS.DeploymentController.TriggerPlayPerformanceEndEvent(nil);
	end
end

util.hotfix_ex(CS.AVGTrigger,'ScriptEndName',ScriptEndName)