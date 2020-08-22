local util = require 'xlua.util'
xlua.private_accessible(CS.AllyTeam)

local SetHp = function(self,jsonData)
	self:SetHp(jsonData);
	if not self.canSupply then
		self.ammo = 100;
		self.mre = 100;
	end
end
util.hotfix_ex(CS.AllyTeam,'SetHp',SetHp)