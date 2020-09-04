local util = require 'xlua.util'

local GetItem_New = function(item)
	if type(item) ~= "number" and item ~= nil and item.itemId ~= nil then		
		return CS.GameData.GetItem(item.itemId)
	else 
		return CS.GameData.GetItem(item)
	end
end

local skillBelong_New = function(self)
	if self.belong == CS.Belong.neutral then
		return 3;
	elseif self.belong == CS.Belong.friendly then
		return 1;
	elseif self.belong == CS.Belong.enemy then
		return 2;
	elseif self.belong == CS.Belong.hide then
		return 99;
	elseif self.belong == CS.Belong.ingore then
		return 100;
	else
		return 0;
	end
end

local hasFriendTeam_New = function(self)
	if self.friendlyTeamId ~= 0 then
		return true;
	elseif self.sangvisTeamId ~= 0 then
		return true;
	elseif self.squadTeamInstanceIds.Count>0 then
		return true;
	elseif self.allyTeamInstanceIds.Count>0 then
		for i=0,self.allyTeamInstanceIds.Count -1 do
			local allyteam = CS.GameData.missionAction.listAllyTeams:GetDataById(self.allyTeamInstanceIds[i]);
			if allyteam ~= nil and allyteam.currentBelong == CS.TeamBelong.friendly then
				return true;
			end
		end
	end
	return false;
end

util.hotfix_ex(CS.GameData,'GetItem',GetItem_New)
util.hotfix_ex(CS.SpotAction,'get_skillBelong',skillBelong_New)
util.hotfix_ex(CS.SpotAction,'get_hasFriendTeam',hasFriendTeam_New)
