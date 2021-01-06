local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamFloatingInfo)

local RefreshBuffUI = function(self)
	self:RefreshBuffUI();
	local gobjBattleSkillIcon = self.transform:Find("Ally/BuffList/BattleSkillItem").gameObject;
	local imageBattleSkillIcon = self.transform:Find("Ally/BuffList/BattleSkillItem/Pic"):GetComponent(typeof(CS.UnityEngine.UI.Image));
	if self.allyTeamController.allyTeam.currentBelong ~= CS.TeamBelong.friendly then
		gobjBattleSkillIcon:SetActive(false);
		return;
	end
	local fairy = self.allyTeamController.allyTeam.currentFairy;
	if fairy == nil or fairy.info.type ~= CS.FairyType.Battle then
		gobjBattleSkillIcon:SetActive(false);
		return;
	end
	if fairy.mainSkill.surplusTurn>0 then
		gobjBattleSkillIcon:SetActive(false);
		return;	
	end
	if fairy.mainSkill.consumption > CS.Data.FairySupportCommand then
		gobjBattleSkillIcon:SetActive(false);
		return;
	end
	if not fairy.autoSkill then
		gobjBattleSkillIcon:SetActive(false);
		return;
	end
	gobjBattleSkillIcon:SetActive(true);
	local skill = CS.ResManager.GetObjectByPath("Pics/Icons/Skill/"..fairy.mainSkill.bInfo.code);
	if skill ~= nil then
		imageBattleSkillIcon.sprite = skill:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite;
	end
end

util.hotfix_ex(CS.DeploymentAllyTeamFloatingInfo,'RefreshBuffUI',RefreshBuffUI)
