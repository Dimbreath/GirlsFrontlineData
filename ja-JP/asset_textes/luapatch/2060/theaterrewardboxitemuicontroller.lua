local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterRewardBoxItemUIController)

local SetRewardSendState = function(self,state)
	--local ids = {};
	--if state:ContainsKey("2") then
	--	for i=0,state["2"].Count-1 do
	--		ids[i] = state["2"][i];
	--		print(ids[i]);
	--	end
	--end
	--local pathList = CS.System.Collections.Generic.List(CS.System.String)();
	--state:Clear();
	--self:SetRewardSendState(state); 
	--if ids ~= nil then
	--	for i=0,ids.Count-1 do
	--		print("Getids"..ids[i]);
	--		print("Info"..self.m_TheaterInfo.id);
	--		if ids[i] == self.m_TheaterInfo.id then
	--			print("true");
	--			self.m_TextRewardSendState.text = CS.Data.GetLang(210195);
	--			self.m_ImageRewardState.color = CS.UnityEngine.Color(134/255,134/255,134/255,1);
	--			self.m_ButtonRewardSend.onClick:RemoveAllListeners();
	--		end
	--	end
	--end
	self.m_TheaterOccupiedReward = state;
	self.m_TextRewardSendState.text = CS.Data.GetLang(210193);
	self.m_ImageRewardState.color = CS.UnityEngine.Color(1,192/255,0,1);
	self.m_ButtonRewardSend.onClick:RemoveAllListeners();
	self.m_ButtonRewardSend:AddOnClick(function()
		self:OnClickSendTheaterReward();
	end);
	if CS.GameData.theaterEventSelfAction.mDicTheaterAction:ContainsKey(self.m_TheaterInfo.id) then
		if CS.GameData.theaterEventSelfAction.mDicTheaterAction[self.m_TheaterInfo.id].self_battle_pt ~= 0 then
			self.m_TextRewardSendState.text = CS.Data.GetLang(210193);
			self.m_ImageRewardState.color = CS.UnityEngine.Color(1,192/255,0,1);
		else
			self.m_TextRewardSendState.text = CS.Data.GetLang(210194);
			self.m_ImageRewardState.color = CS.UnityEngine.Color(1,1,1,1);
			self.m_ButtonRewardSend.onClick:RemoveAllListeners();		
		end
	else
		self.m_TextRewardSendState.text = CS.Data.GetLang(210194);
		self.m_ImageRewardState.color = CS.UnityEngine.Color(1,1,1,1);
		self.m_ButtonRewardSend.onClick:RemoveAllListeners();			
	end
	if CS.GameData.theaterEventCommonAction.mDicTheaterAction:ContainsKey(self.m_TheaterInfo.id) then
		local action = CS.GameData.theaterEventCommonAction.mDicTheaterAction[self.m_TheaterInfo.id];
		if action.common_battle_pt < self.m_TheaterInfo.gauge then
			self.m_TextRewardSendState.text = CS.Data.GetLang(210181);
			self.m_ImageRewardState.color = CS.UnityEngine.Color(1,1,1,1);
			self.m_ButtonRewardSend.onClick:RemoveAllListeners();		
		end	
	else
		self.m_TextRewardSendState.text = CS.Data.GetLang(210181);
		self.m_ImageRewardState.color = CS.UnityEngine.Color(1,1,1,1);
		self.m_ButtonRewardSend.onClick:RemoveAllListeners();	
	end
	local check,ids = state:TryGetValue('2');
	if ids ~= nil then
		for i=0,ids.Count-1 do
			print("Getids"..ids[i]);
			print("Info"..self.m_TheaterInfo.id);
			if ids[i] == self.m_TheaterInfo.id then
				print("true");
				self.m_TextRewardSendState.text = CS.Data.GetLang(210195);
				self.m_ImageRewardState.color = CS.UnityEngine.Color(134/255,134/255,134/255,1);
				self.m_ButtonRewardSend.onClick:RemoveAllListeners();
			end
		end
	end
end
util.hotfix_ex(CS.TheaterRewardBoxItemUIController,'SetRewardSendState',SetRewardSendState)