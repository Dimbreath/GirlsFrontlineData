local util = require 'xlua.util'
xlua.private_accessible(CS.CommonLive2DController)
local CommonLive2DController_TryLoadLive2D = function(self,live2DPath, isDestroy, prefabType)
	if (self:TryLoadLive2D(live2DPath, isDestroy, prefabType)) then
		if (self.mLive2DData~=nil and self.mLive2DData.skinType == 1) then
			self.currModel:setLipSync(false);
    	end
    	return true;
    end
	
	return false;

end
util.hotfix_ex(CS.CommonLive2DController,'TryLoadLive2D',CommonLive2DController_TryLoadLive2D)
