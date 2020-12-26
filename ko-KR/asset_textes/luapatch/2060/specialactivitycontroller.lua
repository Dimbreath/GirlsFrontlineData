local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialActivityController)

local ShowLockObj = function(self,campion,campionObj)
	self:ShowLockObj(campion,campionObj);
	local lock = campionObj.transform:Find("Lock");
	if lock ~= nil then
		lock.gameObject:SetActive(true);
	end
end

util.hotfix_ex(CS.SpecialActivityController,'ShowLockObj',ShowLockObj)
