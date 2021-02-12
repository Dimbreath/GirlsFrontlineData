local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.gsEffect)
xlua.private_accessible(CS.GF.Battle.BattleController)

local CreateInst = function(self)
	
	if self.mEffectCfg ~= nil and self.mEffectCfg.code == "timelineExcuBeta" then
		if self.mSkillCfg ~= nil  and self.mSkillCfg.self ~= nil and CS.ConfigData.IsSangvisSkillPerformanceOn(self.mSkillCfg.self.gun.id) then
			print ("Lua")
			local t = self.mSkillCfg
			self.mSkillCfg = CS.GF.BattleSkillCfgEx.Def
			self:CreateInst()
			self.mSkillCfg = t
		end
	else
		self:CreateInst()
	end
end
util.hotfix_ex(CS.GF.Battle.gsEffect,'CreateInst',CreateInst)

