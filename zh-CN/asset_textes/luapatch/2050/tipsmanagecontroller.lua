local util = require 'xlua.util'
xlua.private_accessible(CS.TipsManageController)
local TipsManageController_InitUIElements = function(self)
	self:InitUIElements();
	self.DefaultSprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2050/spriteDefult");
	self.OnClickSprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2050/spriteOnClick");
	self.FlickerSprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2050/spriteFlicker");
end
util.hotfix_ex(CS.TipsManageController,'InitUIElements',TipsManageController_InitUIElements)