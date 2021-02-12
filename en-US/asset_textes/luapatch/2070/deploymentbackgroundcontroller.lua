local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBackgroundController.MapLayerData)
xlua.private_accessible(CS.DeploymentBackgroundController)

local Init = function(self)
	self:Init();
	if CS.DeploymentBackgroundController.currentLayerData ~= nil then
		CS.DeploymentBackgroundController.currentLayerData:ShowEffect();
	end
	CS.DeploymentBuildSkillItem.showSelectSpot = false;
end
local Awake = function(self)
	if CS.DeploymentBackgroundController.currentLayerData ~= nil then
		local effect = CS.DeploymentBackgroundController.currentLayerData.effect;
		if effect ~= nil and not effect:isNull() then
			CS.UnityEngine.Object.DestroyImmediate(effect);
		end		
	end
	self:Awake();
end
util.hotfix_ex(CS.DeploymentBackgroundController,'Init',Init)
util.hotfix_ex(CS.DeploymentBackgroundController,'Awake',Awake)