local util = require 'xlua.util'
xlua.private_accessible(CS.CommonCombatSettlementController)
local SetRank = function(self,rank,isDisplayRank)
    self:SetRank(rank,isDisplayRank);
	if rank ~= CS.Rank.D and rank ~= CS.Rank.C or CS.GameData.currentSelectedMissionInfo.isEndless then
		self.transform:Find('Guide').gameObject:SetActive(false);
	end
end
util.hotfix_ex(CS.CommonCombatSettlementController,'SetRank',SetRank)