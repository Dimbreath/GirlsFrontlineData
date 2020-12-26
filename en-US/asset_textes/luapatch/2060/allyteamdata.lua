local util = require 'xlua.util'
xlua.private_accessible(CS.AllyTeam)

local SetHp = function(self,jsonData)
	self:SetHp(jsonData);
	if not self.canSupply then
		self.ammo = 100;
		self.mre = 100;
	end
end

local get_currentFairy = function(self)
	if self._currentFairy == nil then
		local allyFairyInfo = CS.GameData.listAllyFairy:GetDataById(self.allyTeamInfo.allyFairyid);
		if allyFairyInfo ~= nil then
			self._currentFairy = CS.Fairy(allyFairyInfo);
			self._currentFairy.id = self.teamId;
			if self.showAmmoMre then
				self._currentFairy.isFriendFairy = false;
			else
				self._currentFairy.isFriendFairy = true;
			end
		end
	end
	return self._currentFairy;
end
util.hotfix_ex(CS.AllyTeam,'SetHp',SetHp)
util.hotfix_ex(CS.AllyTeam,'get_currentFairy',get_currentFairy)