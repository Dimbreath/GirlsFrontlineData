local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleController)
xlua.private_accessible(CS.BattleUIPauseController)

local BattleController_Awake = function(self)
	if CS.UnityEngine.Application.loadedLevelName == "Battle" then
		if CS.BattleUIPauseController.Instance == nil or CS.BattleUIPauseController.Instance:isNull() then
			CS.BattleUIPauseController._inst = self.transform:Find("Canvas/UI/PausePanel"):GetComponent(typeof(CS.BattleUIPauseController));
		end
		if CS.BattleUIController.Instance == nil or CS.BattleUIController.Instance:isNull() then
			CS.BattleUIController.Instance =  self.transform:Find("Canvas"):GetComponent(typeof(CS.BattleUIController));
		end
		if CS.BattleUIManualSkillController.Instance == nil or CS.BattleUIManualSkillController.Instance:isNull() then
			CS.BattleUIManualSkillController.Instance =  self.transform:Find("Canvas/UI/ManualPanel"):GetComponent(typeof(CS.BattleUIManualSkillController));
		end
		if CS.BattleDPSController.Instance == nil or CS.BattleDPSController.Instance:isNull() then
			CS.BattleDPSController.Instance = self.transform:Find("Canvas/SafeRect/DPS"):GetComponent(typeof(CS.BattleDPSController));
		end
		print("CS.BattleUIPauseController.Instance: "..tostring(CS.BattleUIPauseController.Instance.gameObject));
		print("CS.BattleUIController.Instance: "..tostring(CS.BattleUIController.Instance.gameObject));
		print("CS.BattleUIManualSkillController.Instance: "..tostring(CS.BattleUIManualSkillController.Instance.gameObject));
		print("CS.BattleDPSController.Instance: "..tostring(CS.BattleDPSController.Instance.gameObject));
	end
	
	self:Awake()
	local TeamIDList = {337207,334907,333601,333602,333603,333905,333906,333907,334601,334602,334603,336401,336402,336403,336501,336502,336503,336601,336602,336603,336719,336801,336802,336803 }
	local spotInfo = CS.GameData.engagedSpot
	local findFlag = false
	if spotInfo == nil then
		
	else	

		for i=1,#TeamIDList do
			if spotInfo.enemyTeamId == TeamIDList[i]then
				CS.UnityEngine.Camera.main.transform.localPosition = CS.UnityEngine.Vector3(-1.4,0,0)
			end
			for j=0,spotInfo.allyTeamInstanceIds.Count-1 do
				local allyTeam = CS.GameData.missionAction.listAllyTeams:GetDataById(spotInfo.allyTeamInstanceIds[j])
				if allyTeam.currentBelong ~= CS.TeamBelong.friendly then
					if allyTeam.EnemyTeamId == TeamIDList[i] then
						CS.UnityEngine.Camera.main.transform.localPosition = CS.UnityEngine.Vector3(-1.4,0,0)
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

util.hotfix_ex(CS.GF.Battle.BattleController,'Awake',BattleController_Awake)