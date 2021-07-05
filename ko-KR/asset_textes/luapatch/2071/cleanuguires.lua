local util = require 'xlua.util'
xlua.private_accessible(CS.CleanUGUIRes)

local OnDestroy = function(self)
	CS.ResManager.ResClean();
end

util.hotfix_ex(CS.CleanUGUIRes,'OnDestroy',OnDestroy)