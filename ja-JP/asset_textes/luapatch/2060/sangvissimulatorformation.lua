local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisFormaionController)

local UpdataTeamLabels = function(self,teamid)
	self:UpdataTeamLabels(teamid)
	local totalPoint = 0
	local nightPoint = 0
	if self.currentTeam:GetType() == typeof(CS.SangvisTeam) then
		for i=0,self.currentTeam.Count-1 do
			totalPoint = totalPoint + self.currentTeam[i]:GetPoint(true,false,false,self.currentTeam)
			nightPoint = nightPoint + self.currentTeam[i]:GetPoint(true,false,true,self.currentTeam)
		end
		self.textTotalPoint.text = tostring(totalPoint)
		self.textNightPoint.text = tostring(nightPoint)
		self.nowTotalPoint = totalPoint
		self.nowNightPoint = nightPoint
		self:CheckTotalPointAnimation(self.nowTotalPoint, self.nowNightPoint)
	end
	
end
util.hotfix_ex(CS.SangvisSimulatorFormation,'UpdataTeamLabels',UpdataTeamLabels)