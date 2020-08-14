local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelLine)
local Awake = function(self)
	self:Awake();
	self.BezierRenderer:SetWidth(0.3,0.3);
end

util.hotfix_ex(CS.OPSPanelLine,'Awake',Awake)
