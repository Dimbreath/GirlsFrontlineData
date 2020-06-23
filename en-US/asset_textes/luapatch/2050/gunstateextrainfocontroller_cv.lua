local util = require 'xlua.util'
xlua.private_accessible(CS.GunStateExtraInfoController)

local function MySplit(szFullString, szSeparator)  
    if string.find(szFullString, szSeparator) == nil then
        return {szFullString}   
    end
    local nFindStartIndex = 1  
    local nSplitIndex = 1  
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

local ExtraCV = function(self)
    self:Extra()

    if CS.GunStateController.Instance.currentShowSkinId == 0 then 
        local illustratorCV = ""

        if self.gunInfo.isMindupdate then
            local mindGun = nil
            for i = 0, CS.GameData.listGun.Count - 1 do
                if CS.GameData.listGun[i].info.id == self.gunInfo.id then
                    mindGun = CS.GameData.listGun[i]
                    break
                end
            end

            if mindGun ~= nil and mindGun.mod == 3 then
                illustratorCV = self.gunInfo.extra
            else
                local oriGunId = self.gunInfo.id - 20000
                local oriGunInfo = CS.GameData.listGunInfo:GetDataById(oriGunId)

                if oriGunInfo ~= nil then 
                    illustratorCV = oriGunInfo.extra
                end
            end
        else
            illustratorCV = self.gunInfo.extra
        end

        --设置
        if illustratorCV ~= "" then
            local array = MySplit(illustratorCV, ',')
            for j = 1, #array, 1 do  -- 拆出来有多少个东西
                if array[j] == "" then
                    array[j] = "--"
                end

                if j == 1 then
                    self.textIllustrator.text = array[j] 
                elseif j == 2 then
                    self.textCVJP.text = array[j]
                end
            end
        end
    end
end

util.hotfix_ex(CS.GunStateExtraInfoController,'Extra',ExtraCV)