local util = require 'xlua.util'
xlua.private_accessible(CS.RetireController)
local OnClickAdd = function(self,i)
	if i == 3 and self.listFactorySmallSangvisItemController.Count >= CS.RetireController.MAX_RETIRE_NUM then
		CS.CommonController.LightMessageTips(CS.Data.GetLang(32238));
	else
		self:OnClickAdd(i);
	end
end
util.hotfix_ex(CS.RetireController,'OnClickAdd',OnClickAdd)