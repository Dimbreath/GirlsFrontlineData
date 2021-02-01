local util = require 'xlua.util'
xlua.private_accessible(CS.Data)
local _ChangeDicTeamTypeAndClearGunInfo = function(teamId)
	CS.Data.ChangeDicTeamTypeAndClearGunInfo(teamId);
	local con = CS.GameData.dictTeamFairy:ContainsKey(teamId);
	if con then
		CS.GameData.dictTeamFairy[teamId].teamId =0;
		CS.GameData.dictTeamFairy:Remove(teamId);
	end 
end
util.hotfix_ex(CS.Data,'ChangeDicTeamTypeAndClearGunInfo',_ChangeDicTeamTypeAndClearGunInfo)