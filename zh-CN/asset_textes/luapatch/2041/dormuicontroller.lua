local util = require 'xlua.util'
xlua.private_accessible(CS.DormUIController)
local OnClickGiftButton = function(self)
	local canvas = CS.UnityEngine.GameObject.Find("/Canvas");
	local rectBG = canvas.transform:Find("BoxPanel/GiftList/Background");
	rectBG.anchorMax = CS.UnityEngine.Vector2(0.5,1);
	rectBG.anchorMin = CS.UnityEngine.Vector2(0.5,0);
	rectBG.offsetMax = CS.UnityEngine.Vector2(1440,0);
	rectBG.offsetMin = CS.UnityEngine.Vector2(-1440,0);
	self:OnClickGiftButton();
end
local OnPanelInit = function(self,name)
	self:OnPanelInit(name);
	if name == "Home" then
		local textEdit = self.uiHolder:GetUIElement("Home/Edit/Text", typeof(CS.ExText));
		local str = CS.Data.GetLang(31863);
		if textEdit ~= nil and str ~= nil and #str > 0 then
			textEdit.text = str;
		end
		textEdit = nil;
		str = nil;
	end
end
local mySwitchDormRoom = function(self, order)
	pcall(function() self:SwitchDormRoom(order) end)
end
util.hotfix_ex(CS.DormUIController,'SwitchDormRoom',mySwitchDormRoom)
util.hotfix_ex(CS.DormUIController,'OnClickGiftButton',OnClickGiftButton)
util.hotfix_ex(CS.DormUIController,'OnPanelInit',OnPanelInit)