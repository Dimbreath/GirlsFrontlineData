local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionMissionDetailController)

function Split(szFullString, szSeparator)
	local nFindStartIndex = 0
	local nSplitIndex = 0
	local nSplitArray = {}
	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
		end
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

local UpdateEventData = function(self)
	self:UpdateEventData();
	if self.currentAutoMissionInfo ~= nil then
		local expMul = CS.Data.GetExpEventMultiple();
		if expMul == 1 then
			self.txEventExp.transform.parent.gameObject:SetActive(false);
		else
			self.txEventExp.transform.parent.gameObject:SetActive(true);
			self.txEventExp.text = "+"..tostring((expMul - 1)*100.0).."%";
		end
	end
	if not CS.System.String.IsNullOrEmpty(self.mission.missionInfo.difficultyRecommend) then
		local txt = Split(self.mission.missionInfo.difficultyRecommend,';');
		self.textLevelCondition.text = CS.System.String.Format(CS.Data.GetLang(40241),txt[1]);
		self.textGriffinCondition.text = CS.System.String.Format(CS.Data.GetLang(40242),txt[0]);
	end
end
util.hotfix_ex(CS.MissionSelectionMissionDetailController,'UpdateEventData',UpdateEventData)