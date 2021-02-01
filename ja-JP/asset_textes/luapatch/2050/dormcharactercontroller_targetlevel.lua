local util = require 'xlua.util'
xlua.private_accessible(CS.DormCharacterController)

function math.clamp(v, minValue, maxValue)  
    if v < minValue then
        return minValue
    end
    if( v > maxValue) then
        return maxValue
    end
    return v 
end

local GiveConfirmBox = function (self, message, handler )
    local box = self:DormGiveConfirmBox(message, handler)

    if self.currentGift.info.exp > 0 and self.gun.sangvisInfo ~= nil then
        local favorLimit = 2147483647
        if self.currentGift.info.favor > 0 then
            favorLimit = math.ceil((self.gun.currentMaxFavor - self.gun.favor) / self.currentGift.info.favor)
        end
        local maxExp = CS.GameData.SangvisLevelToSumExp(self.gun.levelUpperLimit - 1)
        local levelLimit = math.ceil((maxExp - self.gun.experience) / self.currentGift.info.exp)

        box:InitNumLimit(math.clamp(math.min(favorLimit, levelLimit), 1, self.currentGift.num), self.currentGift.num)
    end

    return box
end

--移到DormCharacterController.lua
--[[local GetConfirmDesc = function(self)
    local desc = self:GiftConfirmDescription()

    if self.currentGift.info.exp > 0 and self.gun.sangvisInfo ~= nil and self.gun:IsLevelMax() == false then 
    
		local targetLevel = math.min(ExpToLevelSangvis(self.gun.experience + self.currentGift.info.exp * self.mGiftNum), self.gun.levelUpperLimit)
		local txt = CS.System.String.Format(CS.Data.GetLang(31694), self.currentGift.info.name, self.mGiftNum, 
			self.gun.sangvisInfo.name, self.gun.level, self.currentGift.info.exp * self.mGiftNum, targetLevel)

		return txt
    else	
    	return desc
    end
end--]]
util.hotfix_ex(CS.DormCharacterController,'DormGiveConfirmBox',GiveConfirmBox)
--util.hotfix_ex(CS.DormCharacterController,'GiftConfirmDescription',GetConfirmDesc)
