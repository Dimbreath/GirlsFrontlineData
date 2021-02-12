local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSpotController)

local SpotCapture = function()
	CS.DeploymentController.TriggerSpotCaptureEvent();
end
local OnFinishAnimationEvent = function(self)
	CS.DeploymentController.AddAction(SpotCapture,0.1);
end

local Init = function(self)
	self:Init();
	if self.effect ~= nil and not self.effect:isNull() then
		CS.UnityEngine.Object.DestroyImmediate(self.effect);
	end
	if not self.packageIgnore then
		self:ShowCommonEffect();
	end
end

local OnPointerDown = function(self,eventData)
	self:OnPointerDown(eventData);
	CS.DeploymentSpotController.time = -1;
end

util.hotfix_ex(CS.DeploymentSpotController,'OnFinishAnimationEvent',OnFinishAnimationEvent)
util.hotfix_ex(CS.DeploymentSpotController,'Init',Init)
util.hotfix_ex(CS.DeploymentSpotController,'OnPointerDown',OnPointerDown)
