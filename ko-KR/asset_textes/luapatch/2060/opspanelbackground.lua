local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelBackGround)

local OnPointerUp = function(self,eventData)
	CS.OPSPanelController.Instance:CancelMission();
end

util.hotfix_ex(CS.OPSPanelBackGround,'OnPointerUp',OnPointerUp)
