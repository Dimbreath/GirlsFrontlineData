local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentFriendlyTeamController)

local scale
local pos
local LoadRecordData = function(self)
	CS.DeploymentMapDragController.playerScale = scale;
	CS.DeploymentMapDragController.playerPos = pos;
end

local DeploymentFriendlyTeamController_MoveDirect = function (self)
	self:MoveDirect();
	if CS.GameData:CheckEngage() then
	 	CS.DeploymentMapDragController.Instance:SavePlayerRecordPos();
		scale = CS.DeploymentMapDragController.playerScale;
		pos = CS.DeploymentMapDragController.playerPos;
		--CS.CommonController.Invoke()
		CS.DeploymentController.AddAction(LoadRecordData,1.1);
	end
end

util.hotfix_ex(CS.DeploymentFriendlyTeamController,'MoveDirect',DeploymentFriendlyTeamController_MoveDirect)