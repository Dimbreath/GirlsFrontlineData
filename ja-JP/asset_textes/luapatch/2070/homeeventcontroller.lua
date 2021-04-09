local util = require 'xlua.util'
xlua.private_accessible(CS.HomeEventController)

local InitUIElements = function(self)	
	self:InitUIElements();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Korea or CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Tw then
		local image0 = self.transform:Find("SafeRect/Main/Daily/Main/7days/7days_main/LoginBounes/Title"):GetComponent(typeof(CS.ExImage));
		image0.sprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2070/7daysLoginBounes");
		local image1 = self.transform:Find("SafeRect/Main/Daily/Main/7days/7days_main/Purchasetoget/Title"):GetComponent(typeof(CS.ExImage));
		image1.sprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2070/7daysPurchasetoget");
		local image2 = self.transform:Find("SafeRect/Main/Daily/Main/7days/7days_main/Trade/Title"):GetComponent(typeof(CS.ExImage));
		image2.sprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2070/7daysTrade");
	end
end
util.hotfix_ex(CS.HomeEventController,'InitUIElements',InitUIElements)

