local util = require 'xlua.util'
xlua.private_accessible(CS.Data)

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
	if actorType == CS.FetterActorType.gun then
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
	if actorType == CS.FetterActorType.gun then
		--CS.NDebug.LogError("GetFetterActorLevel_New:gun")

		local maxLevel = 0
		for i = 0, CS.GameData.listGun.Count - 1 do
            if CS.GameData.listGun[i].info.id == FetterGetGunOrgId(id) or CS.GameData.listGun[i].info.id == FetterGetGunModId(id) then
            	local level = CS.GameData.listGun[i].level
                	if level > maxLevel then
            		maxLevel = level
            	end
            end
        end

        return maxLevel
	else
		return CS.Data.GetFetterActorLevel(actorType, id)
	end
end

local GetFetterActorFavor_New = function(actorType, id)
	if actorType == CS.FetterActorType.gun then
		--CS.NDebug.LogError("GetFetterActorFavor_New:gun")

		local maxFavor = 0
		for i = 0, CS.GameData.listGun.Count - 1 do
            if CS.GameData.listGun[i].info.id == FetterGetGunOrgId(id) or CS.GameData.listGun[i].info.id == FetterGetGunModId(id) then
            	local favor = CS.GameData.listGun[i].uiFavor
            	if favor > maxFavor then
            		maxFavor = favor
            	end
            end
        end

        return maxFavor
	else
		return CS.Data.GetFetterActorFavor(actorType, id)
	end
end

local IsSoulBound_New = function(actorType, id)
	if actorType == CS.FetterActorType.gun then
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

-- local UpdateBadge_New = function(self)
-- 	if self.type == CS.Badge.BadgeType.ExistIllusOrgMapAward then
-- 	 	if self.transform.gameObject.activeInHierarchy then
-- 			CS.NDebug.LogError("UpdateBadge_New")
-- 			local isActive = CS.GameFunctionSwitch.GetGameFunctionOpen(CS.GameFunctionSwitch.GameFunction.org_map) and CS.OrganizationMapController.GetOrganizationCanRewardDeps().Count > 0
-- 			self.GoBadge:SetActive(isActive)
-- 			self.isActive = isActive
-- 		end
-- 	else
-- 		self:UpdateBadge()
-- 	end
-- end

util.hotfix_ex(CS.Data,'FetterActorIsCollect',FetterActorIsCollect_New)
util.hotfix_ex(CS.Data,'GetFetterActorLevel',GetFetterActorLevel_New)
util.hotfix_ex(CS.Data,'GetFetterActorFavor',GetFetterActorFavor_New)
util.hotfix_ex(CS.Data,'IsSoulBound',IsSoulBound_New)