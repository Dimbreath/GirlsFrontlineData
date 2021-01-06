local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterRewardBoxItemUIController)
local TheaterRewardBoxItemUIController_SetRewardSendState = function(self,state)
	 self:SetRewardSendState(state);
	 local text = self.m_TextRewardSendState.text;--210194:未参与
	 if text == CS.Data.GetLang(210194) then
	 	self.m_ImageRewardState.color = CS.UnityEngine.Color.white;
	 end
	 if CS.GameData.theaterEventSelfAction.mDicTheaterAction:ContainsKey(self.m_TheaterInfo.id) == true then 
	 	if text == CS.Data.GetLang(210194) and CS.GameData.theaterEventSelfAction.mDicTheaterAction[self.m_TheaterInfo.id].self_battle_pt ~= 0 then
	 		local sendState = CS.Data.GetLang(210193);--210193:可领取
	 		self.m_TextRewardSendState.text = sendState;
        	self.m_ImageRewardState.color = CS.UnityEngine.Color.white;
        	 
        	self.m_ButtonRewardSend.AddOnClick(self:OnClickSendTheaterReward());
        	sendState=nil;
	 	end
	 end
	 text=nil;
end
util.hotfix_ex(CS.TheaterRewardBoxItemUIController,'SetRewardSendState',TheaterRewardBoxItemUIController_SetRewardSendState)
