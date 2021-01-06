local util = require 'xlua.util'
xlua.private_accessible(CS.AdjustAdjutantScaleController)

local OnClickSwitchDamaged = function(self)
	self:OnClickSwitchDamaged()
	if self.editAdjutantInfo.GetAdjutantType == CS.AdjutantInfo.AdjutantType.GUN then
		local picController = CS.HomeController.Instance.adjutantController:GetPicController(self.isLeftAdjutant);
		if picController ~= nil and picController.transform.childCount > 1 then
			picController:SetLayer("Live2DBG");
		end
		picController = nil;
	end
end

util.hotfix_ex(CS.AdjustAdjutantScaleController,'OnClickSwitchDamaged',OnClickSwitchDamaged)