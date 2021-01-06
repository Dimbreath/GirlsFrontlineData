local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionMissionDetailController)

local UpdateEventData = function(self)
	self:UpdateEventData();
	if not CS.System.String.IsNullOrEmpty(self.mission.missionInfo.difficultyRecommend) then
		local txt = split(self.mission.missionInfo.difficultyRecommend,';');
		self.textLevelCondition.text = CS.System.String.Format(CS.Data.GetLang(40241),txt[2]);
		self.textGriffinCondition.text = CS.System.String.Format(CS.Data.GetLang(40242),txt[1]);
	end
end
function split(s, delim)
	if type(delim) ~= "string" or string.len(delim) <= 0 then
	  return
	end
   
	local start = 1
	local t = {}
	while true do
	local pos = string.find (s, delim, start, true) -- plain find
	  if not pos then
	   break
	  end
   
	  table.insert (t, string.sub (s, start, pos - 1))
	  start = pos + string.len (delim)
	end
	table.insert (t, string.sub (s, start))
   
	return t
  end
util.hotfix_ex(CS.MissionSelectionMissionDetailController,'UpdateEventData',UpdateEventData)