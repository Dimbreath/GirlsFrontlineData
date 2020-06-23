local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionSimCombatInfoController)

function RequestRecoverBPHandle(self,...)
	self:RequestRecoverBPHandle(...)
	if CS.GameData.userInfo.sangvisBpFree < CS.UserInfo.SANGVIS_BP_MAX and CS.GameData.userInfo.bpFree >= CS.UserInfo.BP_MAX then
		self:InvokeRepeating("UpdateRecoverTime", 0, 1)
	end
end
function RequestRecoverSangvisBPHandle(self,...)
	self:RequestRecoverSangvisBPHandle(...)
	if CS.GameData.userInfo.bpFree < CS.UserInfo.BP_MAX and CS.GameData.userInfo.sangvisBpFree >= CS.UserInfo.SANGVIS_BP_MAX then
		self:InvokeRepeating("UpdateRecoverTime", 0, 1)
	end
end
util.hotfix_ex(CS.MissionSelectionSimCombatInfoController,'RequestRecoverBPHandle',RequestRecoverBPHandle)
util.hotfix_ex(CS.MissionSelectionSimCombatInfoController,'RequestRecoverSangvisBPHandle',RequestRecoverSangvisBPHandle)