local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentMapDragController)
local mapDragController_mapSize = function(self)
	return self.mapSize*2;
end

util.hotfix_ex(CS.DeploymentMapDragController,'get_mapSize',mapDragController_mapSize)
--util.hotfix_ex(CS.DeploymentMapDragController,'SavePlayerRecordPos',DeploymentMapDragController_SavePlayerRecordPos)