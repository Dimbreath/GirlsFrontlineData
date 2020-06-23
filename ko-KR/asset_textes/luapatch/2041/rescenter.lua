local util = require 'xlua.util'
xlua.private_accessible(CS.ResCenter)
local _OnLevelWasLoaded = function(self, scene, mode)
	self:_OnLevelWasLoaded(scene, mode);
	if scene.name == "Deployment" or scene.name == "Battle" then
		CS.CommonLoadController.allow = false;
	end
end
local OnLoadScenePrefab = function(self, bigObj)
	self:OnLoadScenePrefab(bigObj);
	CS.CommonLoadController.allow = true;
end
util.hotfix_ex(CS.ResCenter,'OnLoadScenePrefab',OnLoadScenePrefab)
util.hotfix_ex(CS.ResCenter,'_OnLevelWasLoaded',_OnLevelWasLoaded)