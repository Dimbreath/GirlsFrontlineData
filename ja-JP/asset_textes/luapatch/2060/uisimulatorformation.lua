local util = require 'xlua.util'
xlua.private_accessible(CS.UISimulatorFormation)

local SetSangvisLeader = function(self,gun)

	local ans = self:SetSangvisLeader(gun)
	if ans then
		if CS.UISimulatorFormation.isTargetTrain then
			if gun ~= nil and CS.TargetTrainGameData.instance:HaveSquadAssistSangvis(gun.id) then
				CS.TargetTrainGameData.instance:RemoveSquadAssistSangvis(gun.id)
			end
		else
			local assistTeamId = CS.TheaterTeamData.instance:GetSangvisAssistTeamId(gun);
			if assistTeamId > 0 then
				CS.TheaterTeamData.instance:SetSquad(assistTeamId, nil);
				self.isChangedSquad = true;
			end
			assistTeamId = nil;
		end
	end
	return ans
end
local _SimulatorChangeGunTeam = function(self,selectedGun)
	self:SimulatorChangeGunTeam(selectedGun);
	self:UpdateTotalPoint();
end
util.hotfix_ex(CS.UISimulatorFormation,'SetSangvisLeader',SetSangvisLeader)
util.hotfix_ex(CS.UISimulatorFormation,'SimulatorChangeGunTeam',_SimulatorChangeGunTeam)