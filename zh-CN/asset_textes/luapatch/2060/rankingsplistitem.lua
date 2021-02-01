local util = require 'xlua.util'
xlua.private_accessible(CS.RankingSPListItem)

local ShowTargetTrainSettlement = function(self)
	local data = CS.TargetTrainRecordData()
	if self.ranking_data.targetTrainLog ~= nil and self.ranking_data.targetTrainLog ~= '' then
		local jsonData = CS.LitJson.JsonMapper.ToObject(self.ranking_data.targetTrainLog)
		data.timeStamp = jsonData:GetValue("Timestamp").Int;
		data.battleTime = jsonData:GetValue("BattleTime").Float;
		data.type = jsonData:GetValue("RecordType").Int;
		data.isNight = jsonData:GetValue("isNight").Bool;
		data.DifficultLevel = jsonData:GetValue("DifficultLevel").Int;
		data.dodge_level = jsonData:GetValue("DodgeLevel").Int;
		data.armor_level = jsonData:GetValue("ArmorLevel").Int;
		data.shield_level = jsonData:GetValue("ShieldLevel").Int;
		data.forcefield_level = jsonData:GetValue("ForcefieldLevel").Int;
		data.forcefield_percent = jsonData:GetValue("ForcefieldPercent").Int;
		data.isLifeInfi = jsonData:GetValue("IsLifeInfi").Bool;
		data.isEnemyFullMember = jsonData:GetValue("IsEnemyFullMember").Bool;
		data.isDamageOn = jsonData:GetValue("IsDamageOn").Bool;
		data.enemyID = jsonData:GetValue("enemyID").Int;
		data.totalDamage = jsonData:GetValue("TotalDamage").Long;
		data.totalTakeDamage = jsonData:GetValue("TotalTakeDamage").Int;
		data.totalDefBreak = jsonData:GetValue("TotalDefBreak").Int;
		local StatisticDatas = jsonData:GetValue("StatisticData")
		for j=0,StatisticDatas.Count -1 do
			local statisticData = CS.TargetTrainStatisticData()
			statisticData.type = StatisticDatas:GetValue(j):GetValue("statisticDataType").Int;
			statisticData.infoid = StatisticDatas:GetValue(j):GetValue("infoid").Int;
			statisticData.level = StatisticDatas:GetValue(j):GetValue("level").Int;
			statisticData.skinId = StatisticDatas:GetValue(j):GetValue("skinId").Int;
			statisticData.mod = StatisticDatas:GetValue(j):GetValue("mod").Int;
			statisticData.soulBond = StatisticDatas:GetValue(j):GetValue("soulbond").Bool;
			statisticData.resolutionLevel = StatisticDatas:GetValue(j):GetValue("resolutionLevel").Int;
			statisticData.location = StatisticDatas:GetValue(j):GetValue("location").Int;
			statisticData.position = StatisticDatas:GetValue(j):GetValue("position").Int;
			statisticData.prefixName = StatisticDatas:GetValue(j):GetValue("prefixName").String;
			statisticData.qualityLevel = StatisticDatas:GetValue(j):GetValue("qualityLevel").Int;
			statisticData.rawDamageTotal = StatisticDatas:GetValue(j):GetValue("rawDamageTotal").Int;
			statisticData.shieldDamageTotal = StatisticDatas:GetValue(j):GetValue("shieldDamageTotal").Int;
			statisticData.takeDamageTotal = StatisticDatas:GetValue(j):GetValue("takeDamageTotal").Int;
			statisticData.shieldTakeDamageTotal = StatisticDatas:GetValue(j):GetValue("shieldTakeDamageTotal").Int;
			statisticData.defBreakTotal = StatisticDatas:GetValue(j):GetValue("defBreakTotal").Int;
			statisticData.maxHealth = StatisticDatas:GetValue(j):GetValue("maxHealth").Int;
			statisticData.advance = StatisticDatas:GetValue(j):GetValue("advance").Int;
			data.ListTeamStatisticData:Add(statisticData);
		end
	end
	local prefabResult = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("UGUIPrefabs/MissionSelection/CanvasTargettrainLog"))
	local settlement = prefabResult:GetComponent(typeof(CS.TargetTrainSettlement))
	if CS.TargetTrainRankingUIController.Instance ~= nil then
		CS.TargetTrainRankingUIController.Instance.gameObject:SetActive(false)
	end
	settlement:InitByRecord(data, self.ranking_data.name)
end
util.hotfix_ex(CS.RankingSPListItem,'ShowTargetTrainSettlement',ShowTargetTrainSettlement)