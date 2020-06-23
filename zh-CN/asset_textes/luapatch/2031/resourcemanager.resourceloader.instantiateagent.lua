local util = require 'xlua.util'
xlua.private_accessible(CS.ResourceManager.ResourceLoader.InstantiateAgent)
local Update = function(self,elapseSeconds,realElapseSeconds)
	if self.Task ~= nil then
		for i = 0,self.Task.mInitPer-1 do
			if self.mCloneList.Count == self.Task.mCount then
				break;
			end
			local obj = self.mHelper:InstantiateObject(self.Task.mParent,self.Task.mHolder,self.Task.mWorldSpace);
			self.mCloneList:Add(obj);
			obj = nil;
		end
		if self.mCloneList.Count == self.Task.mCount then
			self.Task:InstantiateAssetFinish(self,self.mCloneList:ToArray(),(CS.System.DateTime.Now - self.Task.mStartTime).TotalSeconds);
			self.Task.Done = true;
		end
	end
end
xlua.hotfix(CS.ResourceManager.ResourceLoader.InstantiateAgent,'Update',Update)