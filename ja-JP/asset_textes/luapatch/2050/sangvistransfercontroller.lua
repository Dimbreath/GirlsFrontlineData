local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisTransferController)

local InitUIElements = function(self)
	self:InitUIElements();
	local itemInfo = CS.GameData.listItemInfo:GetDataById(606);
	self.imgProp.sprite = CS.CommonController.LoadItemIconSprite(itemInfo);
	itemInfo = nil;
	-- 补充语言包
	self.uiHolder:GetUIElement("SwitchBox/AnimaNode/DataRight/Label_0/UI_Text",typeof(CS.ExText)).text = CS.Data.GetLang(31869);
	self.uiHolder:GetUIElement("SwitchBox/AnimaNode/DataRight/Label_4/UI_Text",typeof(CS.ExText)).text = CS.Data.GetLang(31872);
	self.uiHolder:GetUIElement("SwitchBox/Btn_Transfer/UI_Text",typeof(CS.ExText)).text = CS.Data.GetLang(31875);
	
	self.uiHolder:GetUIElement("SwitchBox/AnimaNode/DataLeft/Label_4/SkillNode/SkillEmpty/Tex_Empty",typeof(CS.ExText)).text = CS.Data.GetLang(31078);
	self.uiHolder:GetUIElement("SwitchBox/AnimaNode/DataRight/Label_4/SkillNode/SkillEmpty/Tex_Empty",typeof(CS.ExText)).text = CS.Data.GetLang(31078);
end
local InitTransferProp = function(self,sangvis)
	self:InitTransferProp(sangvis);
	local itemInfo = CS.GameData.listItemInfo:GetDataById(self.itemId);
	self.imgProp.sprite = CS.CommonController.LoadItemIconSprite(itemInfo);
	itemInfo = nil;
end

util.hotfix_ex(CS.SangvisTransferController,'InitUIElements',InitUIElements)
util.hotfix_ex(CS.SangvisTransferController,'InitTransferProp',InitTransferProp)