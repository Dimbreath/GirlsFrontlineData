local util = require 'xlua.util'
xlua.private_accessible(CS.CommonCharacterListController)
local GunFilter = function(self,gun)
	if self.listType == CS.ListType.sangvis_sim then
		gun:UpdateData()
	end
	return self:GunFilter(gun)
end
util.hotfix_ex(CS.CommonCharacterListController,'GunFilter',GunFilter)