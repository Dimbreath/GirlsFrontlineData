local util = require 'xlua.util'
xlua.private_accessible(CS.GameData)
xlua.private_accessible(CS.BattleFieldTeamHolder)
xlua.private_accessible(CS.GF.Battle.BattleCharacterController)
xlua.private_accessible(CS.BattleMemberController)
local TargetBuffID = 0
local TargetBuffID_A = 4097
local TargetBuffID_B = 4101
local TargetBuffID_C = 4102
local TargetBuffID_D = 4117
local TargetSkillID_A = 40621701
local TargetSkillID_B = 40621801
local TargetSkillID_C = 40621901
local TargetSkillID_Switch = 40622001
--找到带Buff的人 然后把它举起来= =
Start = function()

	local character = nil
	local findFlag = false
	local Scale = Info.transform.localScale
	if Scale.x == 1 then
		TargetBuffID = TargetBuffID_A
	end
	if Scale.x == 2 then
		TargetBuffID = TargetBuffID_B
	end
	if Scale.x == 3 then
		TargetBuffID = TargetBuffID_C
	end
	if Scale.x == 4 then
		TargetBuffID = TargetBuffID_D
	end
	print(Scale.x)
	local team = CS.GF.Battle.BattleController.Instance.friendlyTeamHolder.listCharacter
	if team ~= nil then
		for i=0,team.Count-1 do
			character = team[i]
			local currentTier = nil
			local dutarion = nil
			currentTier,dutarion = character.conditionListSelf:GetTierByID(TargetBuffID)
			if currentTier ~= 0 then
				if character:IsSummon() == false and (character.status == CS.GF.Battle.CharacterStatus.fighting or character.status == CS.GF.Battle.CharacterStatus.standby) then
					if character.holder.localPosition.y == 0 then
						character.lifeBar.source = character.holder
						HandleFloat(character.holder)
						TriggerDestroy(character)
					end
				end
			end
		end
	end
end

HandleFloat = function(trans)
	
	local seq = CS.DG.Tweening.DOTween.Sequence()
	CS.DG.Tweening.TweenSettingsExtensions.Append(seq,CS.DG.Tweening.ShortcutExtensions.DOLocalMoveY(trans,2.8,0.65))
	CS.DG.Tweening.TweenSettingsExtensions.Append(seq,CS.DG.Tweening.ShortcutExtensions.DOLocalMoveY(trans,2,0.6))
	CS.DG.Tweening.TweenSettingsExtensions.Append(seq,CS.DG.Tweening.ShortcutExtensions.DOLocalMoveY(trans,2.6,0.6))
	CS.DG.Tweening.TweenSettingsExtensions.Append(seq,CS.DG.Tweening.ShortcutExtensions.DOLocalMoveY(trans,2,0.55))
	CS.DG.Tweening.TweenSettingsExtensions.Append(seq,CS.DG.Tweening.ShortcutExtensions.DOLocalMoveY(trans,2.8,0.6))
	CS.DG.Tweening.TweenSettingsExtensions.Append(seq,CS.DG.Tweening.ShortcutExtensions.DOLocalMoveY(trans,0,0.25))
end

TriggerDestroy= function(character)
	local eulerAngles = Info.transform.localScale
	print(eulerAngles.x)
	if eulerAngles.x == 1 then
		local cfg = CS.GameData.listBTSkillCfg:GetDataById(TargetSkillID_A)
		if cfg ~= nil and character~=nil and character:isNull() == false and character.listMember[0]:isNull() == false and character:IsDead() == false then
			if character.listMember.Count > 0 then
				for i=0,character.listMember.Count-1 do
					local member = character.listMember[i]
					if member.isDead == false then
						print("PlaySkill1")
						member:PlaySkill(cfg,member:GetSkillImpl())
						break
					end
				end
			end
		end
	end
	if eulerAngles.x == 2 then
		local cfg = CS.GameData.listBTSkillCfg:GetDataById(TargetSkillID_B)
		if cfg ~= nil and character~=nil and character:isNull() == false and character.listMember[0]:isNull() == false and character:IsDead() == false then
			if character.listMember.Count > 0 then
				for i=0,character.listMember.Count-1 do
					local member = character.listMember[i]
					if member.isDead == false then
						print("PlaySkill2")
						member:PlaySkill(cfg,member:GetSkillImpl())
						break
					end
				end
			end
		end
	end
	if eulerAngles.x == 3 then
		local cfg = CS.GameData.listBTSkillCfg:GetDataById(TargetSkillID_C)
		if cfg ~= nil and character~=nil and character:isNull() == false and character.listMember[0]:isNull() == false and character:IsDead() == false then
			if character.listMember.Count > 0 then
				for i=0,character.listMember.Count-1 do
					local member = character.listMember[i]
					if member.isDead == false then
						print("PlaySkill3")
						member:PlaySkill(cfg,member:GetSkillImpl())
						break
					end
				end
			end
		end
	end
	-- 这里把占位技能上给单位使得它无法换位
	local cfg = CS.GameData.listBTSkillCfg:GetDataById(TargetSkillID_Switch)
	if cfg ~= nil and character~=nil and character:isNull() == false and character.listMember[0]:isNull() == false and character:IsDead() == false then
		--产生技能所带的buff
		if character.listMember.Count > 0 then
			for i=0,character.listMember.Count-1 do
				local member = character.listMember[i]
				if member.isDead == false then
					print("PlaySkillswitch")
					member:PlaySkill(cfg,member:GetSkillImpl())
					break
				end
			end
		end		
	end
end
