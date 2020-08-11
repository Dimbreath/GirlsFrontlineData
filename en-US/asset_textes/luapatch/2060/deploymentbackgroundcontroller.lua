local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBackgroundController)
local RequestMissionCombinationHandle = function(self,data)
	self:RequestMissionCombinationHandle(data);
	for i=0,self.listSpot.Count-1 do
		if self.listSpot[i].packageIgnore then
			for j=0,self.listSpot[i].routLines.Length-1 do
				while self.listSpot[i].routLines[j].transform.childCount>0 do
					CS.UnityEngine.Object.DestroyImmediate(self.listSpot[i].routLines[j].transform:GetChild(0).gameObject);
				end
			end
		end
	end
end
util.hotfix_ex(CS.DeploymentBackgroundController,'RequestMissionCombinationHandle',RequestMissionCombinationHandle)