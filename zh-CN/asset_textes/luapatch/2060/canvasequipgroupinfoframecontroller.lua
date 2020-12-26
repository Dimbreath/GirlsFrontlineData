local util = require 'xlua.util'
xlua.private_accessible(CS.CanvasEquipGroupInfoFrameController)
xlua.private_accessible(CS.SkillTitleGroupController)
local myInitData = function(self, equipGroupData, gun)
    self:InitData(equipGroupData, gun)
	self.gameObject:GetComponent(typeof(CS.UnityEngine.Canvas)).sortingOrder = 4;
end
local myInitSkillInfo = function(self, unLockNum, unLock, equipGroupData, isGun)
    self:InitSkillInfo(unLockNum, unLock, equipGroupData, isGun)
	self.uIText.text = equipGroupData.Name;
	
end
local myStart = function(self)
    self:Start()
	self.textSkill1info.resizeTextForBestFit = true;
	self.textSkill2info.resizeTextForBestFit = true;
end

util.hotfix_ex(CS.CanvasEquipGroupInfoFrameController,'InitData',myInitData)
util.hotfix_ex(CS.CanvasEquipGroupInfoFrameController,'Start',myStart)
util.hotfix_ex(CS.SkillTitleGroupController,'InitSkillInfo',myInitSkillInfo)
