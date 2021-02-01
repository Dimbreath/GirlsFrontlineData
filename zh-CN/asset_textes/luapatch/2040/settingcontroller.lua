local util = require 'xlua.util'
xlua.private_accessible(CS.SettingController)
local Start = function(self)
	self:Start();
	if self.goILike ~= nil then
		self.goILike:SetActive(false);
	end
end
util.hotfix_ex(CS.SettingController,"Start",Start)