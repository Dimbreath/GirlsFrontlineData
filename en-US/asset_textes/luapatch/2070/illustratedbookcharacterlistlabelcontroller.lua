local util = require 'xlua.util'
xlua.private_accessible(CS.IllustratedBookCharacterListLabelController)
local _ShowItems = function(self,obj,errorMsg,userData)
	self:OnLoadPic(obj,errorMsg,userData);
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
 
		if self.picController ~= nil and obj ~= nil and self.gunInfo ==nil then 
			self.picController.imagePic.color = CS.UnityEngine.Color.black;
		end
 
	end
end
util.hotfix_ex(CS.IllustratedBookCharacterListLabelController,'OnLoadPic',_ShowItems)