local util = require 'xlua.util'
xlua.private_accessible(CS.SquadStateRightSideDetailsPanelController)

local SquadAttriAnimation_New = function(self)
	if self.squad == nil then
		return
	end
	if self.squad.fake then
		--CS.NDebug.LogError("lua squad fake return")
		return
	end
	self:SquadAttriAnimation()
end

util.hotfix_ex(CS.SquadStateRightSideDetailsPanelController,'SquadAttriAnimation',SquadAttriAnimation_New)