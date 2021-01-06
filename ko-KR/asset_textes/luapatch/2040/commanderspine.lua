local util = require 'xlua.util'
xlua.private_accessible(CS.CommanderSpine)

local CommanderSpine_GetCommanderSpine = function(userInfo)
	return CS.CommanderSpine.GetCommanderSpineByDress(userInfo.dressedUniformList);
end
util.hotfix_ex(CS.CommanderSpine,'GetCommanderSpine',CommanderSpine_GetCommanderSpine)