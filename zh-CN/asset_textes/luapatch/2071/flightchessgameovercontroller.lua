local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessGameOverController)

local InitUIElements = function(self)
	self:InitUIElements();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Korea or CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Tw then
		local image0 = self.transform:Find("Main/Img_Title"):GetComponent(typeof(CS.ExImage));
		image0.sprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2070/GameOver");
	end
end

util.hotfix_ex(CS.GF.FlightChess.FlightChessGameOverController,'InitUIElements',InitUIElements)

