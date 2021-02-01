local util = require 'xlua.util'
xlua.private_accessible(CS.ImageBufferBlurRefraction)
	
local ImageBufferBlurRefraction_Start = function(self)
	self:Start();
	if self.rootCanvas.renderMode == CS.UnityEngine.RenderMode.ScreenSpaceOverlay and self.showImage ~= nil then
		self.showImage.material = nil;
		self.showImage.color = CS.UnityEngine.Color(0,0,0,0.5);
		--print(self.rootCanvas.renderMode);
	elseif self.showImage ~= nil then
		self.showImage.material = self.showGrabMat;
		self.showImage.color = CS.UnityEngine.Color(0,0,0,0);
		--print(self.rootCanvas.renderMode);
	end
	
end
	
util.hotfix_ex(CS.ImageBufferBlurRefraction,'Start',ImageBufferBlurRefraction_Start)
