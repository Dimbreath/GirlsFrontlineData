local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisMemberLabelController)
local OnClickMemberLabel = function(self)
	if CS.Utility.loadedLevelName == "Theater" then
		self:OpenSangvisList();
	else
		self:OnClickMemberLabel();
	end
end
util.hotfix_ex(CS.SangvisMemberLabelController,'OnClickMemberLabel',OnClickMemberLabel)