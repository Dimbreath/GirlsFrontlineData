local util = require 'xlua.util'
xlua.private_accessible(CS.LoginController)
xlua.private_accessible(CS.TargetTrainGameData)
local Start = function(self)
	self:Start()
	print('Start clear cache');
	if CS.GameData.listFairy ~= nil then
		print("listFairy",CS.GameData.listFairy.Count);
		CS.GameData.listFairy:Clear()
		print("listFairy",CS.GameData.listFairy.Count);
	end
	if CS.TargetTrainGameData._inst ~= nil then
		CS.TargetTrainGameData._inst = nil
	end
	if CS.GameData.listFurniture ~= nil then
		CS.GameData.listFurniture:Clear()
	end
	if CS.GameData.listEstablish ~= nil then
		CS.GameData.listEstablish:Clear()
	end
	if CS.GameData.listEventInfo ~= nil then
		CS.GameData.listEventInfo:Clear()
	end
	if CS.GameData.dictionaryMedal ~= nil then
		CS.GameData.dictionaryMedal:Clear()
	end
	if CS.GameData.listSquadChip ~= nil then
		CS.GameData.listSquadChip:Clear()
	end
	if CS.GameData.listSquadDataAnalysisAction ~= nil then
		CS.GameData.listSquadDataAnalysisAction:Clear()
	end
	if CS.GameData.listSquad ~= nil then
		print("listSquad",CS.GameData.listSquad.Count);
		CS.GameData.listSquad:Clear()
		print("listSquad",CS.GameData.listSquad.Count);
	end
	if CS.GameData.listSquadExpTrainingAction ~= nil then
		CS.GameData.listSquadExpTrainingAction:Clear()
	end
	if CS.GameData.listSquadSkillAction ~= nil then
		CS.GameData.listSquadSkillAction:Clear()
	end
	if CS.GameData.listSquadFixAction ~= nil then
		CS.GameData.listSquadFixAction:Clear()
	end
end
util.hotfix_ex(CS.LoginController,'Start',Start)