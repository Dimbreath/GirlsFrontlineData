local util = require 'xlua.util'
xlua.private_accessible(CS.ShareContentController)
local InitUIElements = function(self)
	self:InitUIElements();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		print(1111);
		if CS.ApplicationConfigData.PlatformChannelId == "OPPO" then
			self.goImages:SetActive(false);
			self:ShowQR(false);
		else
			local tex = CS.ResManager.GetObjectByPath("AtlasClips2060/QR", ".png");
			self.uiHolder:GetUIElement("Images/QR", typeof(CS.UnityEngine.UI.Image)).sprite = CS.ExSprite.Create(tex, CS.UnityEngine.Rect(0,0,260,260), CS.UnityEngine.Vector2(0.5,0.5));
			self.goImages:SetActive(true);
			self:ShowQR(true);
		end
	end
end
util.hotfix_ex(CS.ShareContentController,'InitUIElements',InitUIElements)