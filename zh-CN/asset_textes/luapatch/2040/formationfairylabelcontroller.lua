local util = require 'xlua.util'
xlua.private_accessible(CS.FormationFairyLabelController)
local Init = function(self,...)
	self:Init(...);
	if self.currentFairy ~= nil then
		local starParent = self.transform:Find("InfoNode/StarNode");
		if starParent ~= nil and starParent.gameObject.activeInHierarchy and starParent:GetChild(0).childCount > 0 then
			for i = 1, 5 do
				if i == self.currentFairy.qualityLevel or (self.currentFairy.qualityLevel > 5 and i == 5) then
					self:goStart(i):SetActive(true);
				else
					self:goStart(i):SetActive(false);
				end
			end
		end
		starParent = nil;
	end
end
util.hotfix_ex(CS.FormationFairyLabelController,'Init',Init)
