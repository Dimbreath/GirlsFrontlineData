local util = require 'xlua.util'
xlua.private_accessible(CS.CommonGetNewGunController)
local Start = function(self)
	self:Start();
	if CS.Utility.loadedLevelName == "Home" and not CS.HomeEventController.IsNull() and CS.HomeEventController.Instance.gameObject.activeInHierarchy then
		self.transform:SetParent(CS.HomeEventController.Instance.transform, false);
	end
end
util.hotfix_ex(CS.CommonGetNewGunController,'Start',Start)