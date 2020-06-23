local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchSkillTrainingController)
xlua.private_accessible(CS.HomeController)
xlua.private_accessible(CS.CommonSkillDescription)

local mySlotAndGunStatusToNormal = function(self, gun, id)
    self:SlotAndGunStatusToNormal(gun, id);
	local skill = gun:GetSkill(self.currentSelectSkillNum == 1 and CS.GF.Battle.enumSkill.eSkill1 or CS.GF.Battle.enumSkill.eSkill2);
	skill._info = nil;
end

local mySkillNormalFinishHandle = function(self, gun, id)
    self:SkillNormalFinishHandle(gun, id);
	local skill = gun:GetSkill(id == 1 and  CS.GF.Battle.enumSkill.eSkill1 or CS.GF.Battle.enumSkill.eSkill2);
	skill._info = nil;
end
local myUpdateForceLevelMax = function(self, levelMax)
   if(levelMax == true)
   then
		self.btnForceLevelMaxYes.gameObject:SetActive(true);
		self.txForceLevelMax.color = CS.ColorData.orange;
		local skill = self.gun:GetSkill(self.skillNum);
		skill.level = 10;
		skill._info = nil;
   else
		self.btnForceLevelMaxYes.gameObject:SetActive(false);
		self.txForceLevelMax.color = CS.UnityEngine.Color32(160, 160, 160, 255);
		local skill = self.gun:GetSkill(self.skillNum);
		skill.level = 1;
		skill._info = nil;
   end
   self:Init(self.gun, self.isIllus, self.skillNum);
   
end

util.hotfix_ex(CS.CommonSkillDescription,'UpdateForceLevelMax',myUpdateForceLevelMax)
util.hotfix_ex(CS.HomeController,'SkillNormalFinishHandle',mySkillNormalFinishHandle)
util.hotfix_ex(CS.ResearchSkillTrainingController,'SlotAndGunStatusToNormal',mySlotAndGunStatusToNormal)