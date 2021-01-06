local util = require 'xlua.util'
xlua.private_accessible(CS.WebCameraManager)
local InitCameraCor = function(self)
	return util.cs_generator(function()
		print('lua InitCameraCor');
		coroutine.yield(CS.UnityEngine.WaitForSeconds(2.0));
		print('lua InitCameraCor1');
	end)
end
local AdjustAdjutantScaleController_Init = function(self,info)
	xlua.hotfix(CS.WebCameraManager, 'InitCameraCor', InitCameraCor);
	self:Init(info);
end
local HomeController_OnClickTakePictures = function(self)
	xlua.hotfix(CS.WebCameraManager, 'InitCameraCor', nil);
	self:OnClickTakePictures();
end
util.hotfix_ex(CS.AdjustAdjutantScaleController,'Init',AdjustAdjutantScaleController_Init)
util.hotfix_ex(CS.HomeController, 'OnClickTakePictures', HomeController_OnClickTakePictures)