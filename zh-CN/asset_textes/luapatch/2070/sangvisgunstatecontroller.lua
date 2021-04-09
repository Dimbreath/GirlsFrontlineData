local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisGunStateController)
local _LoadPic = function(self,picCode,isUnlock,isBoss)
	self:LoadPic(picCode,isUnlock,isBoss);
	
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		if self.currentLoadLevel==CS.LoadLevel.IllustratedBook and isUnlock == false and self.picController ~=nil and self.picController.imagePic ~=nil then
			self.picController.imagePic.color= CS.UnityEngine.Color(0,0,0,0);
		end
	end
end
util.hotfix_ex(CS.SangvisGunStateController,'LoadPic',_LoadPic)