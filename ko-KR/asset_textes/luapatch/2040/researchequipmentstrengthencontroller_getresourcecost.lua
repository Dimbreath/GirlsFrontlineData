local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchEquipmentStrengthenController)
local GetResourceCost = function(self, powerupCost, exp)
	if self.currentEquip ~= nil then
		local Rank = CS.EquipRank;
		local rankValue = 0;
		if self.currentEquip.info.rank == Rank.White then
			rankValue = 2;
		elseif self.currentEquip.info.rank == Rank.Blue then
			rankValue = 3;
		elseif self.currentEquip.info.rank == Rank.Green then
			rankValue = 4;
		elseif self.currentEquip.info.rank == Rank.Gold then
			rankValue = 5;
		elseif self.currentEquip.info.rank == Rank.Fairy then
			rankValue = 6;
		end
		local allRemainExp = math.ceil(CS.GameData.dictEquipmentExpInfo[CS.GameData.dictEquipmentExpInfo.Count] * CS.GameData.GetEquipLevelUpRate(rankValue) * self.currentEquip.info.exclusive_rate - self.currentEquip.equip_exp);
		exp = math.min(exp, allRemainExp);
		if exp < 0 then
			exp = 0;
		end
	end
	return self:GetResourceCost(powerupCost, exp);
end

util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'GetResourceCost',GetResourceCost)