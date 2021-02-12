local util = require 'xlua.util'
xlua.private_accessible(CS.OPSRuler)
local ShowButtomImage = function(self)
	self:ShowButtomImage();
	self.rulerBottom.anchoredPosition = CS.UnityEngine.Vector2(2000,0);
end

util.hotfix_ex(CS.OPSRuler,'ShowButtomImage',ShowButtomImage)

