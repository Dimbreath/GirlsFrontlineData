local util = require 'xlua.util'
xlua.private_accessible(CS.GameData)


Start = function()
	local skillcfg = CS.GameData.listBTSkillCfg:GetDataById(tonumber(ID.name))
	CS.BattleStreamerController.Show("",skillcfg.prefixName,skillcfg.description)
end


