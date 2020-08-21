local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamInfoController)

local ShowTeamPanel = function(self,play)
	self:ShowTeamPanel(play);
	self.transform:Find("TeamPanel/Right"):GetComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster)).enabled = true;
end

local MoveLeft = function(self)
	self:MoveLeft();
	self.transform:Find("TeamPanel/Right"):GetComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster)).enabled = false;
end

util.hotfix_ex(CS.DeploymentTeamInfoController,'ShowTeamPanel',ShowTeamPanel)
util.hotfix_ex(CS.DeploymentTeamInfoController,'MoveLeft',MoveLeft)