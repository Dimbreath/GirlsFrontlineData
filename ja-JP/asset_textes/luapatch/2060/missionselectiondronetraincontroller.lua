local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionDroneTrainController)

local Init = function(self)
	self:Init()
	CS.MissionSelectionController.Instance.DroneTrainIntroduce.transform:Find("UI_TextEN").gameObject:GetComponent(typeof(CS.ExText)).text = "Target Practice"
end
util.hotfix_ex(CS.MissionSelectionDroneTrainController,'Init',Init)