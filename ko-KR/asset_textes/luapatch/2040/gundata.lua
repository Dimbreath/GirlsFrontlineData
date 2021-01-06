local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.Gun)
local InitBattleSkill = function(self,missionEnd)
    self:InitBattleSkill(missionEnd)
	for i=0,self.equipList.Count-1 do
		local equip = self.equipList[i]
		if equip.info.skill ~= 0 then
			self:GetSkill(0)._info = nil
		end		
	end
	
end
util.hotfix_ex(CS.GF.Battle.Gun,'InitBattleSkill',InitBattleSkill)