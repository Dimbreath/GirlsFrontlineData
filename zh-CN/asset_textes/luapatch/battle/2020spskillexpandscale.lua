local util = require 'xlua.util'
xlua.private_accessible(CS.BattleFieldTeamHolder)
xlua.private_accessible(CS.GF.Battle.BattleController)

local expandscale


--Awake：初始化数据
Awake = function()
	
end

--Start: 加载组件
Start = function()
	local friendlyTeamHolder = CS.GF.Battle.BattleController.Instance.friendlyTeamHolder
	for i=0,friendlyTeamHolder.listCharacter.Count-1 do
		local character = friendlyTeamHolder.listCharacter[i]
		local characterScale = character.gameObject.transform.localScale
		character.gameObject.transform.localScale = CS.UnityEngine.Vector3(1.05,character.gameObject.transform.localScale.y, character.gameObject.transform.localScale.z)
	end
	
end
Update = function()
end
--depose
OnDestroy =function()

end

