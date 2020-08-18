local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionHolder)
local PlayMove = function(self)
	self:PlayMove();
	local pos = CS.UnityEngine.Vector2(self.transform.localPosition.x,self.transform.localPosition.y);
	CS.OPSPanelBackGround.Instance:Move(pos,true,0.3,0.3,true,CS.OPSPanelBackGround.Instance.mapminScale);
end
util.hotfix_ex(CS.OPSPanelMissionHolder,'PlayMove',PlayMove)