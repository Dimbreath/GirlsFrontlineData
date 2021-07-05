local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessManualController)

local InitUIElements = function(self)
	self:InitUIElements()
	if CS.GF.FlightChess.FlightChessGameController.Instance == nil then
		local downPage = self.transform:Find("RightHolder/ChipListLayout/DownPage"):GetComponent(typeof(CS.UnityEngine.RectTransform))
		downPage.anchorMax = CS.UnityEngine.Vector2(1,1);
        downPage.anchorMin = CS.UnityEngine.Vector2(0,0);
        downPage.offsetMax = CS.UnityEngine.Vector2(0,0);
        downPage.offsetMin = CS.UnityEngine.Vector2(0,0);

		local filterGroup = self.transform:Find("RightHolder/ChipListLayout/DownPage/FilterGroup"):GetComponent(typeof(CS.UnityEngine.RectTransform))
		filterGroup.anchorMax = CS.UnityEngine.Vector2(1,1);
        filterGroup.anchorMin = CS.UnityEngine.Vector2(1,1);
		filterGroup.anchoredPosition = CS.UnityEngine.Vector2(-488.75,53.45);
	end
end
util.hotfix_ex(CS.GF.FlightChess.FlightChessManualController,'InitUIElements',InitUIElements)
