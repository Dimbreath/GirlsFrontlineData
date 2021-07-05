local util = require 'xlua.util'

xlua.private_accessible(CS.CommonCharacterListLabelControler)
local Awake_New = function(self)
	self.imageSkill1Icon.transform.parent.gameObject:SetActive(false);
	self.imageSkill2Icon.transform.parent.gameObject:SetActive(false);
	--CS.NDebug.LogError("Awake_New")
end

util.hotfix_ex(CS.CommonCharacterListLabelControler,'Awake',Awake_New)





