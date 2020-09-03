local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialSpotAction)

local ShowEffect = function(target,effectInfo,autoDestroy,effectObj,lastdelayTime,playsound)
	--if effectObj ~= nil and not effectObj:isNull() then
	--	return;
	--end
	local priority = effectInfo.priority;
	local spot = target:GetComponent(typeof(CS.DeploymentSpotController));
	if spot ~= nil then
		local order = target.transform.parent:GetComponent(typeof(CS.UnityEngine.Canvas)).sortingOrder;
		effectInfo.priority = priority+order;
	end
	effectObj = CS.SpecialSpotAction.ShowEffect(target,effectInfo,autoDestroy,effectObj,lastdelayTime,playsound);
	effectInfo.priority = priority;
	return effectObj;
end

util.hotfix_ex(CS.SpecialSpotAction,'ShowEffect',ShowEffect)