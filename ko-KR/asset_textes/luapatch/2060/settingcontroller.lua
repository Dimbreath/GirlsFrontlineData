local util = require 'xlua.util'
xlua.private_accessible(CS.SettingController)
local Start = function(self)
	self.textClientVersion.text = self.textClientVersion.text.."\nluatest";
end
util.hotfix_ex(CS.SettingController,'Start',Start)