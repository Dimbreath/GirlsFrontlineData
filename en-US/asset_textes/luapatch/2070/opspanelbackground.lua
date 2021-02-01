local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelBackGround)

local InitMap = function(self)
	self:InitMap();
	self:CheckShowMoveOffset();
end

util.hotfix_ex(CS.OPSPanelBackGround,'InitMap',InitMap)

