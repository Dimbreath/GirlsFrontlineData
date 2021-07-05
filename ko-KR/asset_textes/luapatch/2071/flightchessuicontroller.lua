local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessUIController)

local Init = function(self)
	self:Init()
	if CS.GF.FlightChess.FlightChessData.currentRoom.isSingle then
		self.uiMainController.BtnQuickChat.transform:Find("Img_Chat"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(200/255,200/255,200/255,128/255);
	else
		self.uiMainController.BtnQuickChat.transform:Find("Img_Chat"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,1,1,1);
	end

	self.uiMainController.transform:Find("SafeRect/Status/Chessmen/btn_ShowTeam/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(1570)
end
local ShowQuickChat = function(self)
	if CS.GF.FlightChess.FlightChessData.currentRoom ~= nil then
		if CS.GF.FlightChess.FlightChessData.currentRoom.isSingle then
			CS.CommonController.LightMessageTips(CS.Data.GetLang(280409));
		else
			CS.MiniGameQuickChatGroupController.Open(CS.CommonController.MainCanvas.transform);
		end
	end
end
util.hotfix_ex(CS.GF.FlightChess.FlightChessUIController,'Init',Init)
util.hotfix_ex(CS.GF.FlightChess.FlightChessUIController,'ShowQuickChat',ShowQuickChat)

