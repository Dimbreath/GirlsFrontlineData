local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterBattleTeamSelectionUIController)
local CreateSquadList = function(self)
	local theaterInfo = CS.GameData.listTheaterInfo:GetDataById(self.m_TheaterAreaInfo.theater_id);
	self.maxSquadNum = theaterInfo.hoc_formation_number;
	self:CreateSquadList();
end
util.hotfix_ex(CS.TheaterBattleTeamSelectionUIController,'CreateSquadList',CreateSquadList)