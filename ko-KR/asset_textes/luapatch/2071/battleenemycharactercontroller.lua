local util = require 'xlua.util'
xlua.private_accessible(CS.BattleEnemyCharacterController)
--处理特定spine的偏移（让子弹射中特定位置）
--两表一个储存枪（敌人）的识别码 一个储存实际偏移 一一对应
local gunTable = {"GustafL_1","GustafR_1","GustafM_1","GustafL_2","GustafR_2","GustafM_2","GustafL_3","GustafR_3","GustafM_3","Eliza_boss"}
local OffsetDataTableX = {0.9,0.4,3.82,-0.59,0.12,2.12,0.54,0.23,2.85,0}
local OffsetDataTableY = {-1.2,-1.2,0.01,0,0,0,0,0,0.43,2.5}
local OffsetDataTableZ = {3.32,2.24,1.41,-0.36,0.79,0.24,0,0.58,0.23,0}
local Init = function(self,gun,callbackIfDownloaded,showLifeBar)

	if showLifeBar == nil then
		showLifeBar =  true
	end
	self:Init(gun,callbackIfDownloaded,showLifeBar)

	--找到自己
	local Holder = nil
	if self.gameObject~= nil and (not self.gameObject:isNull()) then
		for i =1,#gunTable do
			if gun.code == gunTable[i] then
				Holder = self.holder
				Holder.position = CS.UnityEngine.Vector3(Holder.position.x + OffsetDataTableX[i],Holder.position.y + OffsetDataTableY[i],Holder.position.z + OffsetDataTableZ[i])
				break
			end
		end		 
	end
	if gun.code == 'Ares' then
		if CS.UnityEngine.Application.loadedLevelName == "Cutin" then
			Holder = self.holder
			Holder.position = CS.UnityEngine.Vector3(Holder.position.x,Holder.position.y-1.2,Holder.position.z)
		end
	end
	
end

util.hotfix_ex(CS.BattleEnemyCharacterController,'Init',Init)
