local util = require 'xlua.util'
xlua.private_accessible(CS.FairyStateProfileController)

local myInitData = function(self, currentLoadLevel, fairy, fairyInfo, isGet)
    self:InitData(currentLoadLevel, fairy, fairyInfo, isGet)
	if(currentLoadLevel == CS.FairyLoadLevel.IllustratedBook) then
		self.uiHolder:GetUIElement("MainInfo_text/UI_Text_TypeText",typeof(CS.UnityEngine.GameObject)):SetActive(false);
	end
end

util.hotfix_ex(CS.FairyStateProfileController,'InitData',myInitData)