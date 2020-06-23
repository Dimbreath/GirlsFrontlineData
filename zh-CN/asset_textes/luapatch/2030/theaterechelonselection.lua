local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterEchelonSelection)
local StartBattle = function(self)
	for i = 0, self.arrSquadToBattle.Length-1 do
		local squad = CS.TheaterTeamData.instance:GetSquad(self.arrSquadToBattle[i]);
		if (squad.life == 0) then
			CS.CommonController.MessageBox(CS.Data.GetLang(210198))
			return
		end
	end
	self:StartBattle()
end

util.hotfix_ex(CS.TheaterEchelonSelection,'StartBattle',StartBattle)