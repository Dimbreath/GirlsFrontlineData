local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentMovingOptionController)


local DeploymentMovingOptionController_InitUIElements = function(self)
	self:InitUIElements();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Japan then 
		self.btnSquatDestroy.image.sprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2050/attack");
	end
end

util.hotfix_ex(CS.DeploymentMovingOptionController,'InitUIElements',DeploymentMovingOptionController_InitUIElements)
