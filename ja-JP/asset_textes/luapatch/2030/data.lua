local util = require 'xlua.util'
local get_FairySupportCommand = function()
	if CS.GameData.mTheaterExerciseAction ~= nil then
		return 999;
	else
		return CS.GameData.GetItem(509);
	end
end
local IsCurrentBattleTheaterArea = function(info)
	local res = false
	if CS.GameData.theaterEventCommonAction.mDicTheaterAction:ContainsKey(info.theater_id) then
		local action = CS.GameData.theaterEventCommonAction.mDicTheaterAction[info.theater_id];
		if action.common_battle_pt >= info.start_score and action.common_battle_pt < info.end_score then
			res = true;
		end
		action = nil;
	end
	return res;
end
xlua.hotfix(CS.Data,'get_FairySupportCommand',get_FairySupportCommand)
xlua.hotfix(CS.Data,'IsCurrentBattleTheaterArea',IsCurrentBattleTheaterArea)