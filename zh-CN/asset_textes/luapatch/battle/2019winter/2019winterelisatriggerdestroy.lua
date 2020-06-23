local util = require 'xlua.util'
xlua.private_accessible(CS.GameData)
xlua.private_accessible(CS.BattleFieldTeamHolder)

local TargetBuffIDList = {4092,4093,4094,4095,4096}
local TargetCreationCodeList = {"2019winterCollapseA","2019winterCollapseB","2019winterCollapseC","2019winterCollapseD","2019winterCollapseE"}

--找到带Buff的人 然后干掉对应的创生物
Start = function()

	local character = nil
	local team = CS.GF.Battle.BattleController.Instance.friendlyTeamHolder.listCharacter
	if team ~= nil then
		for i=1,#TargetBuffIDList do
			for j=0,team.Count-1 do
				character = team[j]
				local currentTier = nil
				local dutarion = nil
				currentTier,dutarion = character.conditionListSelf:GetTierByID(TargetBuffIDList[i])
				if currentTier ~= 0 then
					local creation = CS.GF.Battle.BattleController.Instance.holderCreation:Find(TargetCreationCodeList[i].."(Clone)")
					if creation~= nil and creation:isNull() == false then
						CS.UnityEngine.Object.Destroy(creation.gameObject)
						break
					end
				end
			end
		end
	end

end


