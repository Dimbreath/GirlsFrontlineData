local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisLeaderLabelController)
local OnClickLeaderLabel = function(self)
	if CS.Utility.loadedLevelName == "Theater" then
		self:OpenSangvisList();
	else
		self:OnClickLeaderLabel();
	end
end
util.hotfix_ex(CS.SangvisLeaderLabelController,'OnClickLeaderLabel',OnClickLeaderLabel)