local util = require 'xlua.util'
xlua.private_accessible(CS.GunStateController)
local _LoadPic = function(self,isChangeCloth)
	self:LoadPic(isChangeCloth);
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		if self.currentLoadLevel==CS.LoadLevel.IllustratedBook and self.existGun == false then
			self.picController.imagePic.color = CS.UnityEngine.Color(0,0,0,0);
		end
	end
end
util.hotfix_ex(CS.GunStateController,'LoadPic',_LoadPic)