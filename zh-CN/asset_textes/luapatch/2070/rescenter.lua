local util = require 'xlua.util'
xlua.private_accessible(CS.ResCenter)
local OnLevelWasLoaded = function(self,scene,mode)
	local name = CS.UnityEngine.Application.loadedLevelName;
	local loadScenePrefab = true;
	if name == "HotUpdate" then
		loadScenePrefab = false;
	elseif name == "FlightChessGame" then
		loadScenePrefab = false;
	elseif name == "SangvisGasha" then
		loadScenePrefab = false;
	elseif name == "Tutorial" then
		loadScenePrefab = false;
	elseif name == "BattleMoni" then
		loadScenePrefab = false;
	elseif name == "EnemyEditor" then
		loadScenePrefab = false;
	end
	if loadScenePrefab then
		CS.ResManager.GetObjectByPathAsync(function(s)
			self:OnLoadScenePrefab(s);
		end,"SceneSave/" .. name);
	else
		if CS.CommonLoadController.allow then
			CS.CommonLoadController.CloseLoad();
		end
		CS.Utility.TriggerOnLevelWasLoaded();
	end		
end

local LoadScene = function(self,sceneName,direct)
	if sceneName == "HotUpdate" then
		xlua.hotfix(CS.ResCenter,'_OnLevelWasLoaded',nil);
	end
	self:LoadScene(sceneName,direct);
end
util.hotfix_ex(CS.ResCenter,'_OnLevelWasLoaded',OnLevelWasLoaded)
util.hotfix_ex(CS.ResCenter,'LoadScene',LoadScene)

