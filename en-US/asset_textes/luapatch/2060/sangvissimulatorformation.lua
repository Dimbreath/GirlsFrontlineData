local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisFormaionController)

local UpdataTeamLabels = function(self,teamid)
	self:UpdataTeamLabels(teamid);
	if self.currentTeam~=nil and self.currentTeam.Count>0 then
		for k,v in pairs(self.currentTeam.dictLocation) do
	 		if v~=nil and v.teamId==0 and v.location == 0 then 
				v.location=k;
				if v.location==1 then 
					self.currentTeam:UpdateEffectGridBuff();
				end
	 		end
		end
	end 
	local totalPoint = 0;
	local nightPoint = 0;
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