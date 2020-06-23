local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchSkillChoosePanle)

local ResearchSkillChoosePanle_OnClick = function(self,type)
	if type=="BeginTraining" then	
		if self:isSkillLevelMax(self.skillType) then 
			CS.CommonController.MessageBox(CS.Data.GetLang(51021));	
		else
			if self.gun~=nil and self.gun.teamId == 101 then
				self:TipsForRemoveExplorTeam();
                return;
			end
			if self:isCostCoinEnough() then 
				self:BeginNormalTraining();
                CS.ResearchUnlockSlotController.ClearSpinenNameDic();
			else
				CS.CommonController.LightMessageTips(CS.Data.GetLang(51020));
			end
		end
	else
		self:OnClick(type)
	end
end
util.hotfix_ex(CS.ResearchSkillChoosePanle,'OnClick',ResearchSkillChoosePanle_OnClick)