local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterRewardBoxItemUIController)

local SetRewardSendState = function(self,state)
	self:SetRewardSendState(state);
	local m1,m2 = state:TryGetValue("2");
	print(m1);
	print(m2);
	if m1 and m2:Contains(self.m_TheaterInfo.id) then
		self.m_ButtonRewardSend.onClick:RemoveAllListeners();
		self.m_TextRewardSendState.text = CS.Data.GetLang(210195);
		self.m_ImageRewardState.color = CS.UnityEngine.Color(0.52, 0.52, 0.52, 1);
	end
end

util.hotfix_ex(CS.TheaterRewardBoxItemUIController,'SetRewardSendState',SetRewardSendState)