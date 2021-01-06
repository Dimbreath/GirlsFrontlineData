local util = require 'xlua.util'
xlua.private_accessible(CS.RankingListUIController)
local myStart = function(self)
	for i = 0, CS.GameData.listRankInfo.Count - 1, 1 do 
		local info = CS.GameData.listRankInfo[i];
		info.title = info.Title;
	end
    self:Start()
end
util.hotfix_ex(CS.RankingListUIController,'Start',myStart)