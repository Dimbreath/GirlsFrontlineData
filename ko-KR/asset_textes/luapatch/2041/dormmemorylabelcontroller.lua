local util = require 'xlua.util'
xlua.private_accessible(CS.DormMemoryLabelController)
local myOnClickPV = function(self)
    if self.downloading == false and self.unlocked == true and self.downloaded == true then
        CS.DormMemoriesListController.Instance.gameObject:SetActive(false);
		CS.CommonVideoPlayer.PlayVideo(CS.System.String.Format("{0}//{1}", CS.UnityEngine.Application.persistentDataPath, self.pathPV), 
		function() 
			CS.DormMemoriesListController.Instance.gameObject:SetActive(true);
		end);
	else
		self:OnClickPV();
    end
end

util.hotfix_ex(CS.DormMemoryLabelController,'OnClickPV',myOnClickPV)