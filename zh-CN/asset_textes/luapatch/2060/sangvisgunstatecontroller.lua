local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisGunStateController)
local UpdateMarriage = function(self)
	self:UpdateMarriage();
	local tex = CS.ResManager.GetObjectByPath("AtlasClips2060/sangvis_marry_bg",".jpg");
	self.transformBackground:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = CS.ExSprite.Create(tex, CS.UnityEngine.Rect(0,0,1024,1024), CS.UnityEngine.Vector2(0.5, 0.5));
	tex = nil;
end

local UpdatePicAndClothInfo_New = function (self, ...)
	self:UpdatePicAndClothInfo(...)
	if self.picController ~= nil and self.picController.transform:GetComponent(typeof(CS.SangvisSmallPicController)) == nil then
		self.basePlate:SetActive(false)
	end
end

util.hotfix_ex(CS.SangvisGunStateController,'UpdateMarriage',UpdateMarriage)
util.hotfix_ex(CS.SangvisGunStateController,'UpdatePicAndClothInfo',UpdatePicAndClothInfo_New)
