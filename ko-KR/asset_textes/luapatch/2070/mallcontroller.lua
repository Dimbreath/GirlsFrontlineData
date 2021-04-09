local util = require 'xlua.util'
xlua.private_accessible(CS.MallController)
xlua.private_accessible(CS.CommonController)
local myCreateGood = function(self)
    self:CreateGood()
	if(CS.CommonController.sceneJumpType == 209) then
		self:OnClickMaterial(false, CS.MallGoodClassification.Materiel_Resource);
		self:ChangeLeftButtonImage(CS.MallGoodClassification.Material, 5001);
		self:OnClickClothing();
	end
end
util.hotfix_ex(CS.MallController,'CreateGood',myCreateGood)