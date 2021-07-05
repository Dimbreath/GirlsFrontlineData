local util = require 'xlua.util'
xlua.private_accessible(CS.FactoryController)

local InitUIElements = function(self)
	self:InitUIElements();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		local tex2d = CS.ResManager.GetObjectByPath("AtlasClips2070/替代人形拆解", ".png");
		self.btnRetire:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = CS.ExSprite.Create(tex2d,CS.UnityEngine.Rect(0,0,tex2d.width,tex2d.height),CS.UnityEngine.Vector2(0.5,0.5));
	end
end

util.hotfix_ex(CS.FactoryController,'InitUIElements',InitUIElements)


