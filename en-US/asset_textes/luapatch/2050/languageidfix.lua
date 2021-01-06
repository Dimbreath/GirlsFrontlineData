-- 语言包绑定和XMLID修复
local util = require 'xlua.util'
xlua.private_accessible(CS.CommonGetNewSangvisGunController)
xlua.private_accessible(CS.SangvisChipDevelopItemDetail)
xlua.private_accessible(CS.ReinforcementController)
local CommonGetNewSangvisGunController_InitUIElements = function(self)
	self:InitUIElements();
	-- GetSangvis Tex_BossName 修改bestfix
	self.texBossName.resizeTextForBestFit = true;
	self.texBossName.resizeTextMinSize = 10;
	self.texBossName.resizeTextMaxSize = 142;
	self.uiHolder:GetUIElement("Canvas/UiNode/MessageToast/ResolutionMessage/Tex_Message", typeof(CS.ExText)).text = CS.Data.GetLang(260121);
	self.uiHolder:GetUIElement("Canvas/UiNode/RepeatAwardNode/RepeatText/UI_Text", typeof(CS.ExText)).text = CS.Data.GetLang(260120);
end
local SangvisChipDevelopItemDetail_InitUIElements = function(self)
	self:InitUIElements();
	self.uiHolder:GetUIElement("SafeFront/ItemHolder/ItemLayout/ChipDevelopState/Tex_currStateLog", typeof(CS.ExText)).text = CS.Data.GetLang(260055);
	self.uiHolder:GetUIElement("SafeFront/ItemHolder/ItemLayout/ChipDevelopState/Btn_SpeedUp/UI_Text", typeof(CS.ExText)).text = CS.Data.GetLang(260056);
end
local ResearchSkillChoosePanle_InitUIElements = function(self)
	self:InitUIElements();
	self.uiHolder:GetUIElement("Image右侧说明/Coin3/Text", typeof(CS.ExText)).text = CS.Data.GetLang(1176);
end
local ReinforcementController_InitUIElements = function(self)
	self:InitUIElements();
	self.uiHolderRoot:GetUIElement("Top/SelectType/exToggleFusion/Text", typeof(CS.ExText)).text = CS.Data.GetLang(53010);
	self.uiHolderRoot:GetUIElement("Top/SelectType/exToggleFusion/Text_Eng", typeof(CS.ExText)).text = 'Coalition';
	CS.CommonController.GetCanvasMainCanvas().sortingOrder = -1;
end
-- 仅针对陆韩台
if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Korea or CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Tw or CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
util.hotfix_ex(CS.CommonGetNewSangvisGunController,'InitUIElements',CommonGetNewSangvisGunController_InitUIElements)
util.hotfix_ex(CS.SangvisChipDevelopItemDetail,'InitUIElements',SangvisChipDevelopItemDetail_InitUIElements)
util.hotfix_ex(CS.ResearchSkillChoosePanle,'InitUIElements',ResearchSkillChoosePanle_InitUIElements)
end

util.hotfix_ex(CS.ReinforcementController,'InitUIElements',ReinforcementController_InitUIElements)