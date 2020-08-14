local util = require 'xlua.util'
xlua.private_accessible(CS.OrganizationStaffItem)
local InitData = function(self,staff)
	self:InitData(staff);
	if staff ~= nil and staff.type == CS.FetterActorType.sangvis then
		self.strDescTip = CS.PLTable.Instance:GetTableLang(self.strDescTip);
	end
end
util.hotfix_ex(CS.OrganizationStaffItem,'InitData',InitData)