local util = require 'xlua.util'
xlua.private_accessible(CS.CommonCharacterListLabelControler)
local _ShowSkillInfo = function(self)
	self:ShowSkillInfo();
	self:AddCharacterResearchDisabled(false);
end
util.hotfix_ex(CS.CommonCharacterListLabelControler,'ShowSkillInfo',_ShowSkillInfo)