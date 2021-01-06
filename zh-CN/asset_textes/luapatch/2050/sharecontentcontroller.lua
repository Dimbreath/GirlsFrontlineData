local util = require 'xlua.util'
xlua.private_accessible(CS.ShareContentController)
local InitUIElements = function(self)
	self:InitUIElements();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		print(1111);
		local tex = CS.ResManager.GetObjectByPath("AtlasClips2050/QR", ".png");
		self.uiHolder:GetUIElement("Images/QR", typeof(CS.UnityEngine.UI.Image)).sprite = CS.ExSprite.Create(tex, CS.UnityEngine.Rect(0,0,260,260), CS.UnityEngine.Vector2(0.5,0.5));
		self.goImages:SetActive(true);
		self:ShowQR(true);
	end
end
util.hotfix_ex(CS.ShareContentController,'InitUIElements',InitUIElements)