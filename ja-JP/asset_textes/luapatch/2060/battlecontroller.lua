local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleController)
xlua.private_accessible(CS.BattleUIPauseController)
local checkGunID1 = 9064
local checkGunID2 = 9065
local Awake = function(self)
	self:Awake()
	local TeamIDList = {337207,334907,333601,333602,333603,333905,333906,333907,334601,334602,334603,336401,336402,336403,336501,336502,336503,336601,336602,336603,336719,336801,336802,336803 }
	local spotInfo = CS.GameData.engagedSpot
	local findFlag = false
	if spotInfo == nil then
		
	else	
		for i=1,#TeamIDList do
			if spotInfo.enemyTeamId == TeamIDList[i]then
				CS.UnityEngine.Camera.main.transform.localPosition = CS.UnityEngine.Vector3(-1.4,0,0)
				CS.BattleInteractionController.isGuideCanNotScale = false
				CS.BattleInteractionController.isGuideCanNotOffset = false
				self.resetCameraLock = true
				findFlag = true
			end			
			for j=0,spotInfo.allyTeamInstanceIds.Count-1 do
				if findFlag then
					break
				end
				local allyTeam = CS.GameData.missionAction.listAllyTeams:GetDataById(spotInfo.allyTeamInstanceIds[j])
				if allyTeam.currentBelong ~= CS.TeamBelong.friendly then
					--print(allyTeam.EnemyTeamId)
					if allyTeam.EnemyTeamId == TeamIDList[i] then
						CS.UnityEngine.Camera.main.transform.localPosition = CS.UnityEngine.Vector3(-1.4,0,0)
						CS.BattleInteractionController.isGuideCanNotScale = false
						CS.BattleInteractionController.isGuideCanNotOffset = false
						self.resetCameraLock = true
						findFlag = true
						break
					end
				end

			end
			if findFlag then
				break
			end
		end
		
	end
end
local InitBattle = function(self)
	if self.listFriendlyGun ~= nil then
		for i = 0, self.listFriendlyGun.Count -1 do
			local gun = self.listFriendlyGun[i]
			if gun.info.id == checkGunID1 or gun.info.id == checkGunID2 then
				self.isDivisionSpecial = true
				break
			end
		end
	end
	self:InitBattle()
	
end

util.hotfix_ex(CS.GF.Battle.BattleController,'Awake',Awake)
util.hotfix_ex(CS.GF.Battle.BattleController,'InitBattle',InitBattle)