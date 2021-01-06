local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterEchelonSelection)
local _InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("AdaptiveGunNode/Frame/AdvanceGroup/HolderIcons/AdvanceList/Text_GunTitle"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(30112);
end
util.hotfix_ex(CS.TheaterEchelonSelection,'InitUIElements',_InitUIElements)