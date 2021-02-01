local util = require 'xlua.util'
xlua.private_accessible(CS.FormationController)
xlua.private_accessible(CS.RequestExchangeTeam)
local _RequestExchangeTeamHandler = function(self,request)
	self:RequestExchangeTeamHandler(request);
	if request.changeType == 1 then
		self:InitNormalFormaionView(self.currentSelectedTeam);
		self:UpdateTeamLabel();
	end
end
util.hotfix_ex(CS.FormationController,'RequestExchangeTeamHandler',_RequestExchangeTeamHandler)