local util = require 'xlua.util'
xlua.private_accessible(CS.CombatSettlementGuideController)
local myStart = function(self)
    self:Start()
	if CS.Data.GetString("tutorial_guide_switch") == "0" then
		self.gameObject:SetActive(false)
	else
		self.gameObject:SetActive(true)
	end
end
util.hotfix_ex(CS.CombatSettlementGuideController,'Start',myStart)