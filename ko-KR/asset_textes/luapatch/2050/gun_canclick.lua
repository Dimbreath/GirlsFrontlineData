local util = require 'xlua.util'
local get_CanClick = function(self)
	return self.canClick == 1;
end
xlua.hotfix(CS.GF.Battle.Gun,'get_CanClick',get_CanClick)