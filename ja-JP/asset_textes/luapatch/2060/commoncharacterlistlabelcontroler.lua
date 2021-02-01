local util = require 'xlua.util'
xlua.private_accessible(CS.CommonCharacterListLabelControler)
local _ShowSkillInfo = function(self)
	self:ShowSkillInfo();
	self:AddCharacterResearchDisabled(false);
end
local _AddCharacterResearchDisabledo = function(self,active)
	self:AddCharacterResearchDisabled(active);
	if self.listType == CS.ListType.mod then
		self.imageSkill1Icon.transform.parent.gameObject:SetActive(false);
		self.imageSkill2Icon.transform.parent.gameObject:SetActive(false);
	end
end
util.hotfix_ex(CS.CommonCharacterListLabelControler,'ShowSkillInfo',_ShowSkillInfo)
util.hotfix_ex(CS.CommonCharacterListLabelControler,'AddCharacterResearchDisabled',_AddCharacterResearchDisabledo)