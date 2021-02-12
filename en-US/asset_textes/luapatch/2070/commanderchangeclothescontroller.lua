local util = require 'xlua.util'
xlua.private_accessible(CS.CommanderChangeClothesController)
local InitUIElements = function(self)
	self:InitUIElements();
	local text1 = self.transform:Find("DressUpChangeClothesPreview/ChangeColor/Tex_Tips"):GetComponent(typeof(CS.ExText));
	text1.text = CS.Data.GetLang(250060);
	local text2 = self.transform:Find("Btn_Skill/Tex_Skill"):GetComponent(typeof(CS.ExText));
	text2.text = CS.Data.GetLang(250072);
	local text3 = self.transform:Find("DressUpChangeClothesPreview/ChangeColor/Tex_GetColor"):GetComponent(typeof(CS.ExText));
	text3.text = CS.Data.GetLang(250076);
end
util.hotfix_ex(CS.CommanderChangeClothesController,'InitUIElements',InitUIElements)