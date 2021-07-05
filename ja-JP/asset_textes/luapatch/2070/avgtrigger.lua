local util = require 'xlua.util'
xlua.private_accessible(CS.AVGTrigger)


local PlayMissionEndWinAVG = function()
	local currentMission = CS.GameData.listMission:GetDataById(CS.GameData.currentSelectedMissionInfo.id);
	local eventprize = CS.GameData.listMissionEventPrize:GetDataById(CS.GameData.currentSelectedMissionInfo.id);
	if currentMission.missionInfo.avgInfo ~= nil then
		if eventprize ~= nil then
			if currentMission.winCount == 1 then
				CS.AVGTrigger.instance.scriptName = currentMission.missionInfo.avgInfo.first;
			elseif currentMission.winCount < eventprize.bossHpBars then
				CS.AVGTrigger.instance.scriptName = currentMission.missionInfo.avgInfo.mid;
			elseif currentMission.winCount == eventprize.bossHpBars then
				CS.AVGTrigger.instance.scriptName = currentMission.missionInfo.avgInfo["end"];
			else
				if CS.ConfigData.playReplay then
					CS.AVGTrigger.instance.scriptName = currentMission.missionInfo.avgInfo["end"];
				end
			end
		else
			if currentMission.medal1 == false or CS.ConfigData.playReplay then				
				CS.AVGTrigger.instance.scriptName = currentMission.missionInfo.avgInfo["end"];
			end
		end
	end
	CS.AVGTrigger.instance:PlayAVG();
end

local DeploymentController_FinishMissionEvent = function(self)
	if CS.GameData.currentSelectedMissionInfo.missionType ~= CS.MissionType.simulation then
		if CS.GameData.missionResult.rank ~= CS.Rank.C and CS.GameData.missionResult.rank ~= CS.Rank.D then
			CS.DeploymentController.Instance:AddAndPlayPerformance(nil);
			CS.DeploymentController.Instance:AddAndPlayPerformance(PlayMissionEndWinAVG);
			return;
		end
	end
	self:DeploymentController_FinishMissionEvent();
end

local ScriptEndName = function(self,script)
	self.scriptName = script;
	local play = self:PlayAVG();
	if not play and CS.GameData.missionResult == nil then
		CS.DeploymentController.TriggerPlayPerformanceEndEvent(nil);
	end
end
util.hotfix_ex(CS.AVGTrigger,'DeploymentController_FinishMissionEvent',DeploymentController_FinishMissionEvent)
util.hotfix_ex(CS.AVGTrigger,'ScriptEndName',ScriptEndName)