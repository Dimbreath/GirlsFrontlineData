local util = require 'xlua.util'
xlua.private_accessible(CS.GunFetterSkillController)

local UpdateHeader_New = function(self)
	self:UpdateHeader()
	--CS.NDebug.LogError("UpdateHeader_New")
	for i = 0, self.listSkillObj.Count - 1 do
		local desc = self.listSkillObj[i].transform:Find("Tex_SkillDescription"):GetComponent(typeof(CS.ExText))

		if CS.System.String.IsNullOrEmpty(desc.text) then
			self.listSkillObj[i]:SetActive(false)
		end
	end
end

util.hotfix_ex(CS.GunFetterSkillController,'UpdateHeader',UpdateHeader_New)
