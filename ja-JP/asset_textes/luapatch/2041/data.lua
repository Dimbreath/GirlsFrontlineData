local util = require 'xlua.util'
xlua.private_accessible(CS.Data)

local GetCurrentShortestResearchAction = function()
    local ans = nil
	local temp_ans = 2147483647
	if CS.GameData.listResearchAction.Count > 0 then
		for i=0,CS.GameData.listResearchAction.Count-1 do
			local ResAction = CS.GameData.listResearchAction[i]
			if ResAction.endTime - CS.GameData.GetCurrentTimeStamp() <0 then
			else
				if ResAction.endTime < temp_ans then
					temp_ans = ResAction.endTime
					ans = ResAction
				end
			end
		end
		return ans
	else
		return nil
	end
end
util.hotfix_ex(CS.Data,'GetCurrentShortestResearchAction',GetCurrentShortestResearchAction)