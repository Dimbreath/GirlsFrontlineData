local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialSpotAction)
xlua.private_accessible(CS.AVGTrigger)
xlua.private_accessible(CS.ParticleScaler)

local ShowEffect = function(target,effectInfo,autoDestroy,effectObj,lastdelayTime,playsound)
	--if effectObj ~= nil and not effectObj:isNull() then
	--	return;
	--end
	local priority = effectInfo.priority;
	local spot = target:GetComponent(typeof(CS.DeploymentSpotController));
	if spot ~= nil then
		local order = target.transform.parent:GetComponent(typeof(CS.UnityEngine.Canvas)).sortingOrder;
		effectInfo.priority = priority+order;
	end
	effectObj = CS.SpecialSpotAction.ShowEffect(target,effectInfo,autoDestroy,effectObj,lastdelayTime,playsound);
	effectInfo.priority = priority;
	local particle = effectObj:GetComponent(typeof(CS.ParticleScaler));
	if particle.useInDeployment then
		if particle.delayTime ~= 0 then
			print("当前延时"..particle.delayTime);
			for i=0,particle.transform.childCount-1 do
				particle.transform:GetChild(i).gameObject:SetActive(false);
				--local rail = particle.transform:GetChild(i):GetComponent(typeof(CS.UnityEngine.TrailRenderer));
				--if rail ~= nil then
				--	rail.time = 0.5;
				--	rail:Clear();
				--end
			end
		end
	end
	return effectObj;
end

local avgscript;
local PlayAvg = function()
	if CS.GameData.missionAction.mission.winCount == 0 or CS.ConfigData.playReplay then
		CS.AVGTrigger.instance:ScriptEndName(avgscript);
	else
		CS.DeploymentController.Instance:AddAndPlayPerformance(nil);
	end
end

local PlayEffect = function(self)
	print("playeffect");
	self:PlayEffect();
	print(self.currentSpecialSpotInfo.name);
	local index = string.find(self.currentSpecialSpotInfo.name,"[avg]");
	if index ~= nil then
		avgscript = string.sub(self.currentSpecialSpotInfo.name,6);
		if not CS.Data.GetPlayerPrefStringsExists("SpecialSpotAVG", tostring(self.currentSpecialSpotInfo.id)) then
			CS.Data.SetPlayerPrefStrings("SpecialSpotAVG", tostring(self.currentSpecialSpotInfo.id));
			CS.DeploymentController.Instance:AddAndPlayPerformance(PlayAvg);
		end
	end
end

local CheckTeamMovePlayEffect = function(self)
	if self.processEffect ~= nil then
		self.processStartSpot = CS.GameData.listSpotAction:GetDataById(self.processEffect.originSpotId);
	end
	self:CheckTeamMovePlayEffect();
end
util.hotfix_ex(CS.SpecialSpotAction,'ShowEffect',ShowEffect)
util.hotfix_ex(CS.SpecialSpotAction,'PlayEffect',PlayEffect)
--util.hotfix_ex(CS.BuffAction,'CheckTeamMovePlayEffect',CheckTeamMovePlayEffect)