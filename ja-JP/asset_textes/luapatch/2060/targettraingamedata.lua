local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainGameData)

local RemoveSquadAssistSangvis = function(self,id)
	
	self:RemoveSquadAssistSangvis(id)
	if CS.MissionSelectionDroneTrainSettingController.Instance ~= nil then
		local Controller = CS.MissionSelectionDroneTrainSettingController.Instance
		local teamID = 0
		if Controller.TargetTraindata.type == CS.TargetTrainType.single then
			teamID = 1
		end
		if Controller.TargetTraindata.type == CS.TargetTrainType.multiple then
			teamID = 2
		end
		if Controller.TargetTraindata.type == CS.TargetTrainType.special then
			teamID = Controller.TargetTraindata.missionInfoID
		end
		self:SaveSquadDataToLocal(teamID)
	end
	
end
local SetTeamToData = function(self)
	self:SetTeamToData()
	if self.team.Fairy == nil and CS.GameData.dictTeamFairy ~= nil and CS.GameData.dictTeamFairy:ContainsKey(111) then
		CS.GameData.dictTeamFairy:Remove(111)
	end
end
local _TryLoadTeamDataFromLocal = function(self,teamid)
	self:TryLoadTeamDataFromLocal(teamid)
	if self.team ~= nil and self.team.dictLocation[1] ~= nil and self.team.dictLocation[1].location==0 and self.team.dictLocation[1].teamId==0 then
		print(self.team.dictLocation[1].Name);
		self.team.dictLocation[1].location=1;
		self.team:UpdateEffectGridBuff();
	end
end
util.hotfix_ex(CS.TargetTrainGameData,'RemoveSquadAssistSangvis',RemoveSquadAssistSangvis)
util.hotfix_ex(CS.TargetTrainGameData,'SetTeamToData',SetTeamToData)
util.hotfix_ex(CS.TargetTrainGameData,'TryLoadTeamDataFromLocal',_TryLoadTeamDataFromLocal)