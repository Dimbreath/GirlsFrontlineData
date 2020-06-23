local util = require 'xlua.util'
xlua.private_accessible(CS.CombineController)
local UpdateSangvisResolutionUI = function(self,sangvis)
	self:UpdateSangvisResolutionUI(sangvis);
	if sangvis == nil then
		sangvis = self.combineMainSangvis;
	end
	if sangvis.isMaxResolutionLevel then
            self.textBeforeResolve.text = CS.Data.GetLang(32239);
    else
            self.textBeforeResolve.text = CS.Data.GetLang(32206);
	end
end
util.hotfix_ex(CS.CombineController,'UpdateSangvisResolutionUI',UpdateSangvisResolutionUI)