local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionDroneTrainController)

local Init = function(self)
	self:Init()
	local recttrans = self.transform:Find("TargettrainDungeons").gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform))
	recttrans.anchoredPosition = CS.UnityEngine.Vector2(-37,recttrans.anchoredPosition.y)
	CS.MissionSelectionController.Instance.DroneTrainIntroduce.transform:Find("UI_TextEN").gameObject:GetComponent(typeof(CS.ExText)).text = "Target Practice"
	if self.ListItem ~= nil and self.ListItem.Count < 3 then
		self:InitDroneFake()
	end
end
local InitDroneTrainItem = function(self,data)
	if data.isTimeLimit then
		if CS.GameData.GetCurrentTimeStamp() > data.endTime then
			return 
		end
	end
	self:InitDroneTrainItem(data)
end
util.hotfix_ex(CS.MissionSelectionDroneTrainController,'Init',Init)
util.hotfix_ex(CS.MissionSelectionDroneTrainController,'InitDroneTrainItem',InitDroneTrainItem)