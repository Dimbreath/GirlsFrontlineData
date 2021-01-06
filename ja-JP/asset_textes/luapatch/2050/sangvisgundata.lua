local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisTeam)
xlua.private_accessible(CS.SangvisSkillInfo)
xlua.private_accessible(CS.SangvisGun)
local SangvisTeamCurrentCost_Get = function()
	return  CS.Data.GetInt("sangvis_team_cost");
end
local SangvisGun = function(self,...)
	if self.sangvisInfo ~= nil then
		if (self.sangvisInfo.type == CS.SangvisGunType.boss) and (self.Skill1.skillId == self.sangvisInfo.skill_resolution) then
			self:InitSkills();
		end
    end
end
local UpdateData = function(self)
	self:UpdateData()
	if not self.inited then
		return
	end
	if self.location ~= 1 and self.team ~= nil then
		local leader = self.team:GetLeader()
		if leader ~= nil then
			if leader.equipChipData1 ~= nil then
				self.nightResistance = self.nightResistance + leader.equipChipData1.chipCfg.nightResistance
			end
			if leader.equipChipData2 ~= nil then
				self.nightResistance = self.nightResistance + leader.equipChipData2.chipCfg.nightResistance
			end
		end
		self.nightResistance = self.nightResistance / 100
		if self.nightResistance > 1 then
			self.nightResistance = 1
		end
	end
	
end
util.hotfix_ex(CS.SangvisTeam,'get_SangvisTeamCurrentCost',SangvisTeamCurrentCost_Get)
util.hotfix_ex(CS.SangvisGun,'.ctor',SangvisGun)
util.hotfix_ex(CS.SangvisGun,'UpdateData',UpdateData)