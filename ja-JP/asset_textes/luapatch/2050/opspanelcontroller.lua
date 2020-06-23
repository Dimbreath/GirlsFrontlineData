local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local OPSPanelController_RefreshItemNum = function(self)
	self:RefreshItemNum();
	if self.itemuiObj ~= nil then
		self.itemuiObj:SetActive(false);
	end
end
	
util.hotfix_ex(CS.OPSPanelController,'RefreshItemNum',OPSPanelController_RefreshItemNum)
