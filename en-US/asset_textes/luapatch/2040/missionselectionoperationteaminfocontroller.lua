local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionOperationTeamInfoController)

local Show = function(self,...)
	self:Show(...)
	self.transform:SetAsLastSibling()
end
util.hotfix_ex(CS.MissionSelectionOperationTeamInfoController,'Show',Show)