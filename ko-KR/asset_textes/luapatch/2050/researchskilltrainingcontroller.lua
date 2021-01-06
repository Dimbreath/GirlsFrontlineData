local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchSkillTrainingController)
local RequestBeginTrainingHandle = function(self,www)
	self:RequestBeginTrainingHandle(www);
	local us;
	for i = 0,self.listResearchUnlockSlot.Count-1,1 do
		if self.listResearchUnlockSlot[i].slotId == self.currentSlotId then
			us = self.listResearchUnlockSlot[i];
		end
	end
	if us ~= nil then
	us.goButtonSkillTrainingQuicklyFinish:GetComponent(typeof(CS.UnityEngine.UI.Button)).interactable = true;
	end
end
local RequestFairySkillUpgradeHandler = function(self,request)
	self:RequestFairySkillUpgradeHandler(requset);
	local us;
	for i = 0,self.listResearchUnlockSlot.Count-1,1 do
		if self.listResearchUnlockSlot[i].slotId == self.currentSlotId then
			us = self.listResearchUnlockSlot[i];
		end
	end
	if us ~= nil then
	us.goButtonSkillTrainingQuicklyFinish:GetComponent(typeof(CS.UnityEngine.UI.Button)).interactable = true;
	end
end
util.hotfix_ex(CS.ResearchSkillTrainingController,'RequestBeginTrainingHandle',RequestBeginTrainingHandle) 
util.hotfix_ex(CS.ResearchSkillTrainingController,'RequestFairySkillUpgradeHandler',RequestFairySkillUpgradeHandler) 