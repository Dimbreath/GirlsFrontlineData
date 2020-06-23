local util = require 'xlua.util'
xlua.private_accessible(CS.CommonFairyListController)
local myOnClickReturn = function(self)
    self:OnClickReturn()
	if(self.currentListType == CS.FairyListType.Formation and CS.FormationController.Instance ~= nil) then
		CS.FormationController.Instance:UpdateCharacterLabels(CS.FormationController.Instance.currentSelectedTeam)
	end
end
util.hotfix_ex(CS.CommonFairyListController,'OnClickReturn',myOnClickReturn)