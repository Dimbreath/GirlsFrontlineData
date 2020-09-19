local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterEchelonSelectionTeamItem)
local _InitTeam = function(self,teamId,uiType)
	self:InitTeam(teamId,uiType);
	if self.isSangvis==true and self.team ~= nil and self.team.dictLocation[1] ~= nil and self.team.dictLocation[1].location==0 and self.team.dictLocation[1].teamId==0 then
		print(self.team.dictLocation[1].Name);
		self.team.dictLocation[1].location=1;
		self.team:UpdateEffectGridBuff();
	end
end
util.hotfix_ex(CS.TheaterEchelonSelectionTeamItem,'InitTeam',_InitTeam)