local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleCharacterController)
xlua.private_accessible(CS.GF.Battle.CSkillInstance)
local HurtTriggerSkill = function(self,skillId,skillInstance)
	if skillInstance.mSelf ~= nil and skillInstance.mSelf:GetCharacter() == nil then
		local skillCfg = CS.GameData.listBTSkillCfg:GetDataById(skillId * 100 + 1)
		if self.listMember.Count > 0 and skillCfg ~= nil then
			for i=0,self.listMember.Count-1 do
				local member = self.listMember[i]
				if not member.isDead then
					member:PlaySkill(skillCfg,member:GetSkillImpl())
					if not skillCfg.isFormAction then
						break
					end
				end
			end
		end
	else
		local flag = true
		if (skillId) == 901619 or (skillId) == 902619 or (skillId) == 903619
			or (skillId) == 904619 or (skillId) == 905619 or (skillId) == 906619 
			 or (skillId) == 907619 or (skillId) == 908619 or (skillId) == 909619 or (skillId) == 910619 then
			local skillCfg = CS.GameData.listBTSkillCfg:GetDataById(skillId * 100 + 1)
			if CS.GF.Battle.SkillUtils.IsTrigger(skillCfg,self:GetRandomMemberImpl()) then
				flag = true
			else
				flag = false
			end
		end
		if flag then
			self:HurtTriggerSkill(skillId,skillInstance)
		end
		return
	end
	
end
util.hotfix_ex(CS.GF.Battle.BattleCharacterController,'HurtTriggerSkill',HurtTriggerSkill)