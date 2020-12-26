local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSangvisSkillPanelController)

local ShowSelectTarget = function(self,order)
	self:ShowSelectTarget(order);
	if self.missionSkillCfg ~= nil and self.missionSkillCfg.istransfer then
		local tempspot = {};
		for j=0,self.selectSpots.Count-1 do
			local spot = self.selectSpots[j];			
			for l=0,spot.spotAction.listSpecialAction.Count-1 do
				if spot.spotAction.listSpecialAction[l].spotBuffInfo ~= nil and spot.spotAction.listSpecialAction[l].spotBuffInfo.noairborne then
					table.insert(tempspot,spot);
					spot:HideSkillTarget();
				end
			end			
		end
		for i=1,#tempspot do
			self.selectSpots:Remove(tempspot[i]);
		end
	end
end

util.hotfix_ex(CS.DeploymentSangvisSkillPanelController,'ShowSelectTarget',ShowSelectTarget)

