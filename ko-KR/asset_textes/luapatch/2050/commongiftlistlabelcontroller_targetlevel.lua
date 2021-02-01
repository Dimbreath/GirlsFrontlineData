local util = require 'xlua.util'
xlua.private_accessible(CS.CommonGiftListLabelController)

ExpToLevelSangvis = function(sangvisExp)
	local exp = math.min(sangvisExp, CS.Data.GetInt("max_sangvis_exp"))
    local expRemain = exp
    local levelUpperLimit = CS.Data.GetInt("sangvis_lv_max")
    local level = 0
    local expData
    for i = 1, CS.GameData.listSangvisExp.Count do 
        if i >= levelUpperLimit then
            level = levelUpperLimit
            break
        end

        expData = CS.GameData.listSangvisExp:GetDataById(i)
        if expRemain >= expData.exp then    
            expRemain = expRemain - expData.exp     
        else        
            level = i
            break
        end
    end

    return level
end

local GetConfirmDesc = function(self)
    local desc = self:GunGiftConfirmDescription()

    if self.gift.info.exp > 0 and self.currentGun.sangvisInfo ~= nil and self.currentGun:IsLevelMax() == false then 
    
		local targetLevel = math.min(ExpToLevelSangvis(self.currentGun.experience + self.gift.info.exp * self.giftNum), self.currentGun.levelUpperLimit)
		local txt = CS.System.String.Format(CS.Data.GetLang(31694), self.gift.info.name, self.giftNum, 
			self.currentGun.sangvisInfo.name, self.currentGun.level, self.gift.info.exp * self.giftNum, targetLevel)

		return txt
    else	
    	return desc
    end
end

util.hotfix_ex(CS.CommonGiftListLabelController,'GunGiftConfirmDescription',GetConfirmDesc)