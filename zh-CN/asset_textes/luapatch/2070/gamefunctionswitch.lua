local util = require 'xlua.util'
xlua.private_accessible(CS.GameFunctionSwitch)

local Description = function(self)
	if self.functionName == "minigame_flight" then
		return CS.Data.GetLang(280457);
	else
		return self:Description();
	end
end

util.hotfix_ex(CS.GameFunctionSwitch,'Description',Description)
