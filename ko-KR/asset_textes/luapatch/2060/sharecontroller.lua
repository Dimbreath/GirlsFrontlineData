local util = require 'xlua.util'
xlua.private_accessible(CS.ShareButtonController)
xlua.private_accessible(CS.WebCameraManager)
xlua.private_accessible(CS.ShareController)
local _InitUIElements = function(self)
	self:InitUIElements();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		local channel = CS.ApplicationConfigData.PlatformChannelId;
		if channel == "OPPO" then
			self.gameObject:SetActive(false);
			CS.UnityEngine.Object.Destroy(self.button);
			channel=nil;
		end
	end
end
local _OnClick = function(self)
	self:OnClick();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		if CS.ApplicationConfigData.PlatformChannelId == "OPPO" then
			print("share oppo");
			if self.shareController ~=nil then
			self.shareController.btnSina.gameObject:SetActive(false);
			end
		end
	end
end
local _SharePicture = function(self)
	self:SharePicture();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		if CS.ApplicationConfigData.PlatformChannelId == "OPPO" then
			print("share oppo");
			if self.shareController ~=nil then
				self.shareController.btnSina.gameObject:SetActive(false);
			end
		end
	end
end
local _InitPreViewButton = function(self)
	self:InitPreViewButton();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		local channel = CS.ApplicationConfigData.PlatformChannelId;
		if channel == "OPPO" then
			self.exBtnSharePhotoHorizontal.gameObject:SetActive(false);
			self.exBtnSharePhotoVertical.gameObject:SetActive(false);
			channel=nil;
		end
	end
end
util.hotfix_ex(CS.ShareButtonController,'InitUIElements',_InitUIElements)
util.hotfix_ex(CS.ShareButtonController,'OnClick',_OnClick)
util.hotfix_ex(CS.WebCameraManager,'InitPreViewButton',_InitPreViewButton)
util.hotfix_ex(CS.WebCameraManager,'SharePicture',_SharePicture)