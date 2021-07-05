local util = require 'xlua.util'

local updateData = false;
local UpdateInfo = function(self,jsonData)
	updateData = true;
	self:UpdateInfo(jsonData);
end

local PlayEffect = function(self)
	local id = self.missionBuffInfo.birth_effect;
	if updateData then
		self.missionBuffInfo.birth_effect = 0;
	end
	self:PlayEffect();
	self.missionBuffInfo.birth_effect = id;
end

local freeMreAndAmmo = function(self)
	return false;
end

local PlayEffect = function(self)
	if not self.canCheck then
		local index = string.find(self.currentSpecialSpotInfo.name,"[avg]");
		if index ~= nil then		
			local avgtxt = string.sub(self.currentSpecialSpotInfo.name, 6);
			if not CS.Data.GetPlayerPrefStringsExists("SpecialSpotAVG",tostring(self.currentSpecialSpotInfo.id)) then
				CS.Data.SetPlayerPrefStrings("SpecialSpotAVG", tostring(self.currentSpecialSpotInfo.id));
				CS.DeploymentController.Instance:InsertSomePlayPerformances(function ()
					CS.DeploymentController.Instance:AddAndPlayPerformance(function ()
						CS.AVGTrigger.instance:ScriptName(CS.GameData.missionAction.mission, avgtxt); 				
					end)						
				end)
			end
		end
	end
	self:PlayEffect();
	if not self.canCheck then		
		print("插入延时"..self.lastTime);
		CS.DeploymentController.Instance:InsertSomePlayPerformances(function ()
				CS.DeploymentController.Instance:AddAndPlayPerformance(self.lastTime); 
			end)
	end
	self.canCheck = true;
end

util.hotfix_ex(CS.BuffAction,'UpdateInfo',UpdateInfo)
util.hotfix_ex(CS.BuffAction,'PlayEffect',PlayEffect)
util.hotfix_ex(CS.BuffAction,'get_freeMreAndAmmo',freeMreAndAmmo)
util.hotfix_ex(CS.SpecialSpotAction,'PlayEffect',PlayEffect)