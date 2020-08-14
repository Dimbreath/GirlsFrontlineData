local util = require 'xlua.util'
xlua.private_accessible(CS.CombatSettlementGuideController)
local myStart = function(self)
    self:Start()
	if CS.GameFunctionSwitch.GetGameFunctionOpen("tutorial") then
		self.gameObject:SetActive(true)
	else
		self.gameObject:SetActive(false)
	end
end
util.hotfix_ex(CS.CombatSettlementGuideController,'Start',myStart)