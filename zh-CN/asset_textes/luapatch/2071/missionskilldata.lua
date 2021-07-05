local util = require 'xlua.util'

local freeMreAndAmmo = function(self)
	return false;
end


local PlayEffect = function(self)
	if self.birth then
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
	if self.birth then
		print("插入延时"..self.lastTime);
		CS.DeploymentController.Instance:InsertSomePlayPerformances(function ()
			CS.DeploymentController.Instance:AddAndPlayPerformance(self.lastTime); 
		end)
	end
end


util.hotfix_ex(CS.BuffAction,'get_freeMreAndAmmo',freeMreAndAmmo)
util.hotfix_ex(CS.SpecialSpotAction,'PlayEffect',PlayEffect)