local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterCombatSettlementUIController)
local PlayBattleTeamLeader = function(self, result)
	local team = nil;
	if CS.BattleController.Instance.currentSpotAction ~= nil then
		team = CS.GameData.dictTeam[CS.BattleController.Instance.currentSpotAction.friendlyTeamId];
	end		
	if team == nil then 
		for i = 0, result.lastTheaterExerciseAction.theater_teams.Length-1 do
			print('result.lastTheaterExerciseAction.theater_teams[i]',result.lastTheaterExerciseAction.theater_teams[i])
			if CS.TheaterTeamData.instance:GetTeam(result.lastTheaterExerciseAction.theater_teams[i]) ~= nil then
				team = CS.TheaterTeamData.instance:GetTeam(result.lastTheaterExerciseAction.theater_teams[i]);
				break;
			end
		end
	end
	self.mLeftNode:SetActive(false);
	self:SetLeaderPic(team:GetLeader());
	self:SetRank(result.rank);
end
local _InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("TheaterNode/AutoLayoutNode/TotalPointNode/BGNode/UI_Text (1)"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(210123);
end
util.hotfix_ex(CS.TheaterCombatSettlementUIController,'PlayBattleTeamLeader',PlayBattleTeamLeader)
util.hotfix_ex(CS.TheaterCombatSettlementUIController,'InitUIElements',_InitUIElements)