local util = require 'xlua.util'
xlua.private_accessible(CS.CommonCharacterLabelControler)
local CommonCharacterLabelControler_OnLoadPic = function(self,obj,errorMsg,userData)
	if obj~=nil and self.gun ~= userData then
		CS.Utility.Destroy(obj);
	else
		self:OnLoadPic(obj,errorMsg,userData);
	end
end
util.hotfix_ex(CS.CommonCharacterLabelControler,'OnLoadPic', CommonCharacterLabelControler_OnLoadPic);
