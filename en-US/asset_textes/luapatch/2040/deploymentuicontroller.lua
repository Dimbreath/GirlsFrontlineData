local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentUIController)

local showtarget = false;
local DeploymentUIController_CheckAllSpotNum = function(missionwintypeid,logic,showTarget,medal)
	local result = false;
	local process = "";
	--print(CS.DeploymentBackgroundController.Instance.listSpot.Count)
	--print(logic)
	if(CS.DeploymentBackgroundController.Instance.listSpot.Count>tonumber(logic)) then
		result,process = CS.DeploymentUIController.CheckAllSpotNum(missionwintypeid,logic,false,medal);
	end
	return result,process;
end

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

local DeploymentUIController_CheckWinTypeAnd = function(logic,showTarget,medal)
	local temp = Split(logic,',');
	local missionTypeId = tonumber(temp[0]);
	local winTypeInfo = CS.GameData.listMissionWinTypeInfo:GetDataById(missionTypeId);
	local logicResult,process = CS.DeploymentUIController.CheckTypeComplete(winTypeInfo, showTarget, medal);
	for i=1,#temp do
		winTypeInfo =  CS.GameData.listMissionWinTypeInfo:GetDataById(tonumber(temp[i]));
		local result,process1 = CS.DeploymentUIController.CheckTypeComplete(winTypeInfo, showTarget, medal);
		logicResult = logicResult and result;
	end
	return logicResult;
end

local DeploymentUIController_CheckWinTypeOr = function(logic,showTarget,medal)
	local temp = Split(logic,'|');
	local logicResult = DeploymentUIController_CheckWinTypeAnd(temp[0], showTarget, medal);
	for i=1,#temp do
		local result = DeploymentUIController_CheckWinTypeAnd(temp[i], showTarget, medal);
		logicResult = logicResult or result;
	end
	return logicResult;
end
util.hotfix_ex(CS.DeploymentUIController,'CheckAllSpotNum',DeploymentUIController_CheckAllSpotNum)
util.hotfix_ex(CS.DeploymentUIController,'CheckWinTypeAnd',DeploymentUIController_CheckWinTypeAnd)
util.hotfix_ex(CS.DeploymentUIController,'CheckWinTypeOr',DeploymentUIController_CheckWinTypeOr)