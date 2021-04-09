local util = require 'xlua.util'
xlua.private_accessible(CS.IllustratedBookEnemyListLabelController)
local _ShowItems = function(self)
	self:ShowItems();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal and self.illustratedbookguninfo~=nil then
 		
		local count=self.transformPicMask.childCount;
		if count >0 then
			for i=0,count-1,1 do
    			local picImage= self.transformPicMask:GetChild(i):GetComponent(typeof(CS.SangvisSmallPicController))
    			if picImage ~=nil and self.denied.activeSelf == true then
					--print(picImage.gameObject.name);
					picImage.imagePic.color = CS.UnityEngine.Color.black;
				end
				picImage=nil;
			end
		end
 
	end
end
util.hotfix_ex(CS.IllustratedBookEnemyListLabelController,'ShowItems',_ShowItems)