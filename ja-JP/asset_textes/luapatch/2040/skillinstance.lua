local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.CSkillInstance)
--处理特定Movement，使其读取外部位置而非spine位置以适应偏移
local moveTable = {740}

local _HandleMovementtEvent = function(self,pEvent)

	self:_HandleMovementtEvent(pEvent)
	for i = 1,#moveTable do
		if moveTable[i] == pEvent.EffectCfg.id then		
			self.mMovementCtrl.CurPos = self.mSelf:GetPos(false)
			break
		end
	end
end

util.hotfix_ex(CS.GF.Battle.CSkillInstance,'_HandleMovementtEvent',_HandleMovementtEvent)
