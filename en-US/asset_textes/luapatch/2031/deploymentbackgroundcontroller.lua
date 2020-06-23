local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBackgroundController)
local Awake = function(self)
	self:Awake();
	if CS.GameData.currentSelectedMissionInfo.specialType == CS.MapSpecialType.Normal then
		self.cloudMaterial:SetColor("_CloudColor",CS.UnityEngine.Color(0.5,0.5,0.5,0.12));
	end
end
util.hotfix_ex(CS.DeploymentBackgroundController,'Awake',Awake)