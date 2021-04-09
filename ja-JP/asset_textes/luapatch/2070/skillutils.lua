local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.SkillUtils)
local _GetSkillTargetNum = function(first,second)
	
	if second ==nil then
		if first== 30090101 then
			return 3;
		else
			return CS.GF.Battle.SkillUtils.GetSkillTargetNum(first);
		end
	else
		return CS.GF.Battle.SkillUtils.GetSkillTargetNum(first,second);
	end 
end
util.hotfix_ex(CS.GF.Battle.SkillUtils,'GetSkillTargetNum',_GetSkillTargetNum)