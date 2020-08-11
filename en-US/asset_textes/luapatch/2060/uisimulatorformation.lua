local util = require 'xlua.util'
xlua.private_accessible(CS.UISimulatorFormation)

local SetSangvisLeader = function(self,gun)

	local ans = self:SetSangvisLeader(gun)
	if CS.UISimulatorFormation.isTargetTrain and ans then

		if gun ~= nil and CS.TargetTrainGameData.instance:HaveSquadAssistSangvis(gun.id) then
			CS.TargetTrainGameData.instance:RemoveSquadAssistSangvis(gun.id)
		end		
	end
	return ans
end
util.hotfix_ex(CS.UISimulatorFormation,'SetSangvisLeader',SetSangvisLeader)