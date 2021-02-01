local util = require 'xlua.util'
xlua.private_accessible(CS.ResourceManager.ResourceLoader.InstantiateTask)
xlua.private_accessible(CS.ResourceManager.ResourceLoader.LoadAssetTask)
local InstantiateAssetFinish = function(self,agent,cloneList,totalSeconds)
	if self.mCallback ~= nil and not self.mCallback.Target:Equals(nil) then
		self.mCallback(cloneList,self.mUserData,totalSeconds);
	end
end
local OnLoadAssetSuccess = function(self,agent,asset,duration)
	if self.mLoadAssetCallback.LoadAssetSuccessCallback ~= nil and not self.mLoadAssetCallback.LoadAssetSuccessCallback.Target:Equals(nil) then
		self.mLoadAssetCallback.LoadAssetSuccessCallback(self.mAssetName, asset, duration, self.mUserData);
	end
end
xlua.hotfix(CS.ResourceManager.ResourceLoader.InstantiateTask,'InstantiateAssetFinish',InstantiateAssetFinish)
xlua.hotfix(CS.ResourceManager.ResourceLoader.LoadAssetTask,'OnLoadAssetSuccess',OnLoadAssetSuccess)