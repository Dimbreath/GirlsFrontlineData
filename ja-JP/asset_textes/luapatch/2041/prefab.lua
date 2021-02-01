local util = require 'xlua.util'
xlua.private_accessible(CS.Prefab)
local myCreateCommonSquadList = function(holder, listType)
	local returnValue = CS.Prefab.CreateCommonSquadList(holder, listType);
    if (CS.ResCenter.instance.currentSceneName == "Dorm") then
        CS.CommonSquadListController.Instance.transform:Find("Top/HorizontalLayout/Btn_QuickJump").gameObject:SetActive(false);
	end
	return returnValue;
end
util.hotfix_ex(CS.Prefab,'CreateCommonSquadList',myCreateCommonSquadList)