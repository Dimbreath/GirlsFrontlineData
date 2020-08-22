local util = require 'xlua.util'
xlua.private_accessible(CS.SettingController)
local Start = function(self)
	self:Start();
	self.goChangeSever:SetActive(CS.Data.GetBool("translate_switch"));
end
util.hotfix_ex(CS.SettingController,'Start',Start)