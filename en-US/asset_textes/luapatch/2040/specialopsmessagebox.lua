local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialOPSMessageBox)

local SpecialOPSMessageBox_InitUI = function(self)
	self:InitUIElements();
	self.transform:Find("SecretInfoFrame/Btn_Yes"):GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
		self:OnClickCancle();
	end)
end

local SpecialOPSMessageBox__ShowUnclockMission = function(self,num,handler)
	self:ShowUnclockMission(num,handler);
	self.transform:Find("SecretInfoFrame").gameObject:SetActive(false);
end

util.hotfix_ex(CS.SpecialOPSMessageBox,'InitUIElements',SpecialOPSMessageBox_InitUI)
util.hotfix_ex(CS.SpecialOPSMessageBox,'ShowUnclockMission',SpecialOPSMessageBox__ShowUnclockMission)