local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterBattleTeamSelectionUIController)
local CreateSquadList = function(self)
	local theaterInfo = CS.GameData.listTheaterInfo:GetDataById(self.m_TheaterAreaInfo.theater_id);
	self.maxSquadNum = theaterInfo.hoc_formation_number;
	self:CreateSquadList();
end
local CreateTeamList = function(self)
	self.gridLayoutList.cellSize = CS.UnityEngine.Vector2(1036, 255);
	local maxTeamDisplay = CS.GameData.mTheaterExerciseAction.theater_teams.Length;
	local teamTemplate = CS.ResManager.GetObjectByPath("UGUIPrefabs/Theater/TheaterTeamTemplateItem");
	local teamId = 0;
	local canUseTeam = false;
	local team = nil;
	local teamItem = nil;
	for i = 1, maxTeamDisplay do
		teamId = CS.GameData.mTheaterExerciseAction.theater_teams[i - 1];
		canUseTeam = false;
		teamItem = nil;
		if CS.TheaterTeamData.instance:GetTeam(teamId) ~= nil then
			team = CS.TheaterTeamData.instance:GetTeam(teamId);
			for j = 0, team.Count-1 do
				print(team[j]);
				if team[j] ~= nil and team[j].life > 0 then
					canUseTeam = true;
					break;
				end
			end
		end
		if canUseTeam then
			if i <= self.listTeamUIItem.Count then
				teamItem = self.listTeamUIItem[i - 1];
				teamItem.gameObject:SetActive(true);
			else
				teamItem = CS.UnityEngine.Object.Instantiate(teamTemplate):GetComponent(typeof(CS.TheaterEchelonSelectionTeamItem));
				teamItem.transform:SetParent(self.teamParent, false);
				self.listTeamUIItem:Add(teamItem);
			end
			teamItem:InitTeam(teamId, CS.TheaterEchelonSelectionTeamItem.UIType.Battle);
			teamItem:SetUIType(CS.TheaterEchelonSelectionTeamItem.UIType.Battle);
			teamItem:SetHasUseFairyCommand(self.fairySupportCommandRemain);
		end
	end
	maxTeamDisplay = nil;
	teamTemplate = nil;
	teamId = nil;
	canUseTeam = nil;
	team = nil;
	teamItem = nil;
		
end
util.hotfix_ex(CS.TheaterBattleTeamSelectionUIController,'CreateSquadList',CreateSquadList)
util.hotfix_ex(CS.TheaterBattleTeamSelectionUIController,'CreateTeamList',CreateTeamList)