local util = require 'xlua.util'
xlua.private_accessible(CS.Data)
xlua.private_accessible(CS.FetterStoryTaskList)
xlua.private_accessible(CS.FetterStoryMilestone)

function FetterGetGunOrgId(id)
	if id > 20000 then
		return id - 20000
	else
		return id
	end
end

function FetterGetGunModId(id)
	if id > 20000 then
		return id
	else
		return id + 20000
	end
end

local FetterActorIsCollect_New = function(actorType, id)
	if actorType == CS.FetterActorType.gun and CS.GameData.listGunInfo:ContainsKey(FetterGetGunModId(id)) then
		--CS.NDebug.LogError("FetterActorIsCollect_New:gun")

		if CS.GameData.userInfo.dctGunCollect:ContainsKey(FetterGetGunOrgId(id)) or CS.GameData.userInfo.dctGunCollect:ContainsKey(FetterGetGunModId(id)) then
			return true
		else
			return false
		end
	else
		return CS.Data.FetterActorIsCollect(actorType, id)
	end
end

local GetFetterActorLevel_New = function(actorType, id)
	if actorType == CS.FetterActorType.gun and CS.GameData.listGunInfo:ContainsKey(FetterGetGunModId(id)) and FetterActorIsCollect_New(actorType,id) then
		--CS.NDebug.LogError("GetFetterActorLevel_New:gun")

		local maxLevel = 0
		for i = 0, CS.GameData.listGun.Count - 1 do
            if CS.GameData.listGun[i].info.id == FetterGetGunOrgId(id) or CS.GameData.listGun[i].info.id == FetterGetGunModId(id) then
            	local level = CS.GameData.listGun[i].level
                if level > maxLevel then
            		maxLevel = level
					if maxLevel >= 120 then
						break;
					end
            	end
            end
        end

        return maxLevel
	else
		return CS.Data.GetFetterActorLevel(actorType, id)
	end
end

local GetFetterActorFavor_New = function(actorType, id)
	if actorType == CS.FetterActorType.gun and CS.GameData.listGunInfo:ContainsKey(FetterGetGunModId(id)) and FetterActorIsCollect_New(actorType,id) then
		--CS.NDebug.LogError("GetFetterActorFavor_New:gun")

		local maxFavor = 0
		for i = 0, CS.GameData.listGun.Count - 1 do
            if CS.GameData.listGun[i].info.id == FetterGetGunOrgId(id) or CS.GameData.listGun[i].info.id == FetterGetGunModId(id) then
            	local favor = CS.GameData.listGun[i].uiFavor
            	if favor > maxFavor then
            		maxFavor = favor
					if maxFavor >= 2000000 then
						break;
					end
            	end
            end
        end

        return maxFavor
	else
		return CS.Data.GetFetterActorFavor(actorType, id)
	end
end

local IsSoulBound_New = function(actorType, id)
	if actorType == CS.FetterActorType.gun and CS.GameData.listGunInfo:ContainsKey(FetterGetGunModId(id)) and FetterActorIsCollect_New(actorType,id) then
		--CS.NDebug.LogError("IsSoulBound_New:gun")

		for i = 0, CS.GameData.listGun.Count - 1 do
            if CS.GameData.listGun[i].info.id == FetterGetGunOrgId(id) or CS.GameData.listGun[i].info.id == FetterGetGunModId(id) then
            	if CS.GameData.listGun[i].soulBond then
            		return true
            	end
            end
        end

        return false
	else
		return CS.Data.IsSoulBound(actorType, id)
	end
end

local OnTaskBtnClicke_New = function(self)
	CS.FetterStoryTaskList.Open("UGUIPrefabs/Fetter/FetterTaskList")
	CS.FetterStoryTaskList.Instance.bountyLayout:SetActive(false)	
	CS.FetterStoryTaskList.Instance.btnReceiveAll.gameObject:SetActive(false)		
	CS.FetterStoryTaskList.Instance:Invoke("InitData", 0.05)
end

local OnBtnDoneClick_New = function(self)
	CS.FetterStoryTaskList.Open("UGUIPrefabs/Fetter/FetterTaskList")
	CS.FetterStoryTaskList.Instance:InitBountys()
	CS.FetterStoryTaskList.Instance:OnlyShowReward();
end


util.hotfix_ex(CS.Data,'FetterActorIsCollect',FetterActorIsCollect_New)
util.hotfix_ex(CS.Data,'GetFetterActorLevel',GetFetterActorLevel_New)
util.hotfix_ex(CS.Data,'GetFetterActorFavor',GetFetterActorFavor_New)
util.hotfix_ex(CS.Data,'IsSoulBound',IsSoulBound_New)
util.hotfix_ex(CS.FetterStoryMilestone,'OnTaskBtnClicke',OnTaskBtnClicke_New)
util.hotfix_ex(CS.FetterStoryMilestone,'OnBtnDoneClick',OnBtnDoneClick_New)