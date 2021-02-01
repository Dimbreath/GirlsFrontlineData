local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleController)
xlua.private_accessible(CS.BattleUILifeBarController)
--1.处理特定spine的偏移,血条参考位置读一次偏移量
--2.处理逻辑错误导致的召唤物血条意外显示
local Init = function(self,character,showLifeBar)
	--配合夏活spine偏移演出
	if showLifeBar == nil then
		showLifeBar =  true
	end
	if CS.GF.Battle.BattleController.Instance.objectUI == nil or CS.GF.Battle.BattleController.Instance.objectUI:isNull() then
		CS.GF.Battle.BattleController.Instance.objectUI = CS.GF.Battle.BattleController.Instance.gameObject;
	end
	self:Init(character,showLifeBar)
	self:UpdateInfo(character)
	self.source = character.transform:Find("Holder")
	--修复血条showLifeBar参数有问题
	if character.gun:GetType() == typeof(CS.SummonGun) then
		--print(character.gun.summonInfo.name.." "..tostring(character.gun.summonInfo.isHpShowed))
		if character.gun.summonInfo.isHpShowed == false or character.gun.summonInfo.isAssistSquad then
			self.gameObject:SetActive(false)
		end
	end
	if CS.GF.Battle.BattleController.Instance.IsTheaterPerform then
		self.gameObject:SetActive(false)
	end
end

local Awake = function(self)
	self:Awake()
	local TeamIDList = {337207,334907,333601,333602,333603,333905,333906,333907,334601,334602,334603,336401,336402,336403,336501,336502,336503,336601,336602,336603,336719,336801,336802,336803 }
	local TeamIDListOgas = {334402,337001}
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
					--print(allyTeam.EnemyTeamId)
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
		if findFlag == false then
			for i=1,#TeamIDListOgas do
				if spotInfo.enemyTeamId == TeamIDListOgas[i]then
					findFlag = true
					end		
				for j=0,spotInfo.allyTeamInstanceIds.Count-1 do
					local allyTeam = CS.GameData.missionAction.listAllyTeams:GetDataById(spotInfo.allyTeamInstanceIds[j])
					if allyTeam.currentBelong ~= CS.TeamBelong.friendly then
						--print(allyTeam.EnemyTeamId)
						if allyTeam.EnemyTeamId == TeamIDListOgas[i] then
							findFlag = true
							break
						end
					end
				end
				if findFlag then
					--CS.UnityEngine.Camera.main.transform.localPosition = CS.UnityEngine.Vector3(-1.4,0,0)
						CS.BattleInteractionController.isGuideInteractable = false
						CS.BattleInteractionController.isGuideCanNotScale = false
						CS.BattleInteractionController.isGuideCanNotOffset = false
						CS.GF.Battle.SkillUtils.AutoSkill = false
					break
				end
			end
		end
	end
	util.hotfix_ex(CS.BattleUILifeBarController,'Init',Init)	
end

local RequestBattleFinish = function(self,forceLose)
	CS.BattleInteractionController.isGuideInteractable = true
	CS.BattleInteractionController.isGuideCanNotScale = true
	CS.BattleInteractionController.isGuideCanNotOffset = true
	CS.GF.Battle.SkillUtils.LoadAutoSkillPref()
	self:RequestBattleFinish(forceLose)
end


util.hotfix_ex(CS.GF.Battle.BattleController,'Awake',Awake)
util.hotfix_ex(CS.GF.Battle.BattleController,'RequestBattleFinish',RequestBattleFinish)