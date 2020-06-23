local util = require 'xlua.util'
xlua.private_accessible(CS.GriffinEntryMessageBoxController)
local InitUIElements = function(self)
	self:InitUIElements()
	if CS.GF.Battle.BattleController.Instance ~= nil then
		self.canvas.renderMode = CS.UnityEngine.RenderMode.ScreenSpaceOverlay
	end
end
local OnClickClose = function(self)
	if CS.GF.Battle.BattleController.Instance ~= nil and not CS.GF.Battle.BattleController.Instance.gameObject.activeSelf then
		CS.GF.Battle.BattleController.Instance.gameObject:SetActive(true)
	end	
	self:OnClickClose()
end
util.hotfix_ex(CS.GriffinEntryMessageBoxController,'InitUIElements',InitUIElements)
util.hotfix_ex(CS.GriffinEntryMessageBoxController,'OnClickClose',OnClickClose)