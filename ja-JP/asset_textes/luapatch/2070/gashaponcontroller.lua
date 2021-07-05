local util = require 'xlua.util'
xlua.private_accessible(CS.GashaponController)
local _RefreshProbabilityList = function(self,currentSelectGasha)
	self:RefreshProbabilityList(currentSelectGasha);

	if  CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Japan and self.currentItem ~=nil then
		
		self.currentItem.transform:GetChild(0).gameObject:SetActive(true);
		
		--ePlatform_Japan ePlatform_Normal
	end
end
util.hotfix_ex(CS.GashaponController,'RefreshProbabilityList',_RefreshProbabilityList)