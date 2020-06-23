local util = require 'xlua.util'
xlua.private_accessible(CS.ResourceManager.LoadResourceLoader.LoadResourceAgent)
xlua.private_accessible(CS.MissionSelectionController)
local UpdateCampaignData = function(self,id)
	if self.isFirstUpdate or id ~= 0 then
		local cacheGuideAction = self.guideAction;
		self.guideAction = nil;
		if self.mAsyncLoadMissionBarTask ~= nil then
			CS.ResourceManager.LoadResourceLoader.LoadResourceAgent.sLoadingAssetNames:Remove(self.mAsyncLoadMissionBarTask.mAssetName);
		end
		self:UpdateCampaignData(id);
		self.guideAction = cacheGuideAction;
		cacheGuideAction = nil;
	end
end
util.hotfix_ex(CS.MissionSelectionController,'UpdateCampaignData',UpdateCampaignData)