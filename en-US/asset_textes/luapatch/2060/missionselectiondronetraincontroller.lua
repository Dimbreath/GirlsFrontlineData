local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionDroneTrainController)

local Init = function(self)
	self:Init()
	local recttrans = self.transform:Find("TargettrainDungeons").gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform))
	recttrans.anchoredPosition = CS.UnityEngine.Vector2(-37,recttrans.anchoredPosition.y)
	CS.MissionSelectionController.Instance.DroneTrainIntroduce.transform:Find("UI_TextEN").gameObject:GetComponent(typeof(CS.ExText)).text = "Target Practice"
end
util.hotfix_ex(CS.MissionSelectionDroneTrainController,'Init',Init)