local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisGun)
xlua.private_accessible(CS.DeploymentLine)
local get_forceManualSkill = function(self)
	local skill = self:GetSkill(self.forceManualSkillMark)
	local boolflag = false
	if skill.info.is_manual == 1 then
		boolflag = true
	end
	if self.forceManualSkill == boolflag then
		return false
	else
		return true
	end
end

local CheckEffectData = function(self)
	self:CheckEffectData();
	local iter = self.team_Line:GetEnumerator();
	while iter:MoveNext() do
		local team = iter.Current.Key;
		local line = iter.Current.Value;
		if not line:isNull() and not line.gameObject:isNull() then
			--print(team.currentSpot.visible);			
			line.gameObject:SetActive(team.currentSpot.visible);
			if line.endEffect ~= nil and not line.endEffect:isNull() then
				line.endEffect.gameObject:SetActive(team.currentSpot.visible);
			end
		end
	end
	local builder = self.build_Line:GetEnumerator();
	while builder:MoveNext() do
		local build = builder.Current.Key;
		local line = builder.Current.Value;
		if not line:isNull() and not line.gameObject:isNull() then
			line.gameObject:SetActive(build.spot.visible);
			if line.endEffect ~= nil and not line.endEffect:isNull() then
				line.endEffect.gameObject:SetActive(build.spot.visible);
			end
		end
	end
end
util.hotfix_ex(CS.SangvisGun,'get_forceManualSkill',get_forceManualSkill)
util.hotfix_ex(CS.SangvisChipRingSkillData,'CheckEffectData',CheckEffectData)
