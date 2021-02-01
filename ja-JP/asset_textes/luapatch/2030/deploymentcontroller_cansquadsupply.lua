local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)
local CanSquadSupply = function(spot)
	print('CanSquadSupply1');
	if spot.transform == nil then
		return CS.DeploymentController.CanSquadSupply(spot);
	end
	if spot.spotAction ~= nil and spot.spotAction.limitCanSupply then
		print('CanSquadSupply2');
		return true;
	else
		print('CanSquadSupply3');
		return CS.DeploymentController.CanSquadSupply(spot);
	end
end
util.hotfix_ex(CS.DeploymentController,'CanSquadSupply',CanSquadSupply)