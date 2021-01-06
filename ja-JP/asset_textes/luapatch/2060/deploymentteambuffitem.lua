local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamBuffItem)

local Refesh = function(self,teaminfo)
	self:Refesh(teaminfo);
	if self.gameObject ~= nil then
		if CS.System.String.IsNullOrEmpty(self.buffaction.missionBuffInfo.othercode) and CS.System.String.IsNullOrEmpty(self.buffaction.missionBuffInfo.code) then
			self.gameObject:SetActive(false);
		else
			self.gameObject:SetActive(true);
		end
	end
end

util.hotfix_ex(CS.DeploymentTeamBuffItem,'Refesh',Refesh)
