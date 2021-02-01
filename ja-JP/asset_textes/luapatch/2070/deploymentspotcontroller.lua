local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSpotController)

local SpotCapture = function()
	CS.DeploymentController.TriggerSpotCaptureEvent();
end
local OnFinishAnimationEvent = function(self)
	CS.DeploymentController.AddAction(SpotCapture,0.1);
end

util.hotfix_ex(CS.DeploymentSpotController,'OnFinishAnimationEvent',OnFinishAnimationEvent)
