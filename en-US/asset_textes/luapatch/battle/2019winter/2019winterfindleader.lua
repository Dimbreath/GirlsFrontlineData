local util = require 'xlua.util'
xlua.private_accessible(CS.GameData)

local TargetSkillID = 11380301

--Start: 找到队长之后对队长上Buff
Start = function()

	local character = nil
	local team = CS.GF.Battle.BattleController.Instance.listFriendlyGun
	if team ~= nil and team.dictLocation~=nil and team.dictLocation:ContainsKey(1) then
		local gun = team.dictLocation[1]
		character = CS.BattleLuaUtility.GetCharacterByCode(gun.code)
		end
	local cfg = CS.GameData.listBTSkillCfg:GetDataById(TargetSkillID)
	if cfg ~= nil and character~=nil and character:isNull() == false and character.listMember[0]:isNull() == false and character:IsDead() == false then
		--产生技能所带的buff
		CS.GF.Battle.SkillUtils.GenBuff(
			CS.GF.Battle.BattleSkillCfgEx(cfg, false, nil, nil),
			character.listMember[0],
			cfg.buffSelf,
			cfg.buffSelfNum,
			1
		)
	end
end


