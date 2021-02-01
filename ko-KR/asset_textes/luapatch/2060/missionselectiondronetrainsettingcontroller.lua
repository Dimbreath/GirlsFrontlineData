local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionDroneTrainSettingController)

local GoBattle = function(self)
	self:GoBattle()
	if(self.TargetTraindata.type == CS.TargetTrainType.special) then
		if self.targetTraindata.hp_is_re == 1 then
			CS.TargetTrainGameData.instance.isLifeInfi = true
		else
			CS.TargetTrainGameData.instance.isLifeInfi = false
		end
	end
end
util.hotfix_ex(CS.MissionSelectionDroneTrainSettingController,'GoBattle',GoBattle)