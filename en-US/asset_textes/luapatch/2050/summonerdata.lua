local util = require 'xlua.util'
xlua.private_accessible(CS.SummonerData)
local SummonerData_ctor = function(self,...)
	if self.hp <= 0 then
		print("hp set as 1");
		self.hp = 1;
	end
end
util.hotfix_ex(CS.SummonerData,'.ctor',SummonerData_ctor)