local util = require 'xlua.util'
xlua.private_accessible(CS.DormCharacterController)
local cacheLevel = nil; -- 等级缓存
local GiveGift = function(self, gift)
	-- 判断好感，若好感已满且礼物增加好感则提示并返回
	if gift.info ~= nil and gift.info.exp == 0 and gift.info.favor > 0 and self.gun.favor >= self.gun.currentMaxFavor then
		CS.CommonController.LightMessageTips(CS.Data.GetLang(31887));
		return;
	end
	-- 判断等级，若已满级且礼物增加好感则临时降一级，为了绕过C#代码IsLevelMax的判断
	cacheLevel = self.gun.level;
	if gift.info ~= nil and gift.info.exp == 0 and gift.info.favor > 0 and self.gun:IsLevelMax() then
		self.gun.level = self.gun.levelUpperLimit - 1;
	end
	self:GiveGift(gift);
	if cacheLevel ~= nil then
		self.gun.level = cacheLevel;
		cacheLevel = nil;
	end
end
local GiftConfirmDescription = function(self)
	if cacheLevel ~= nil then
		self.gun.level = cacheLevel;
		cacheLevel = nil;
	end

    local desc = self:GiftConfirmDescription()

    if self.currentGift.info.exp > 0 and self.gun.sangvisInfo ~= nil and self.gun:IsLevelMax() == false then 
    
		local targetLevel = math.min(ExpToLevelSangvis(self.gun.experience + self.currentGift.info.exp * self.mGiftNum), self.gun.levelUpperLimit)
		local txt = CS.System.String.Format(CS.Data.GetLang(31694), self.currentGift.info.name, self.mGiftNum, 
			self.gun.sangvisInfo.name, self.gun.level, self.currentGift.info.exp * self.mGiftNum, targetLevel)

		return txt
    else	
    	return desc
    end
end
--DormGiveConfirmBox
util.hotfix_ex(CS.DormCharacterController,'GiveGift',GiveGift)
util.hotfix_ex(CS.DormCharacterController,'GiftConfirmDescription',GiftConfirmDescription)