local util = require 'xlua.util'
xlua.private_accessible(CS.CombatSettlementGuideController)
local myStart = function(self)
	self.transform:Find("ButtonGroup/Layout/Fairy/Img_Background/Img_Icon"):GetComponent(typeof(CS.ExImage)).sprite =  CS.CommonController.LoadPngCreateSprite("DaBao/AtlasClips2060/fairy_icon")
    self:Start()
	if(CS.System.Convert.ToInt16(CS.GameData.missionResult.rank) > 2 or CS.GameData.currentSelectedMissionInfo.isEndless) == false then
		if CS.GameFunctionSwitch.GetGameFunctionOpen("tutorial") then
			self.selfObj:SetActive(true)
		else
			self.selfObj:SetActive(false)
		end
	else
		self.selfObj:SetActive(false)
	end
end
util.hotfix_ex(CS.CombatSettlementGuideController,'Start',myStart)