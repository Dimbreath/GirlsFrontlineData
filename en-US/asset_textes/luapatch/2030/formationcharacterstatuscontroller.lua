local util = require 'xlua.util'
xlua.private_accessible(CS.FormationCharacterStatusController)
local NewTile = function(self)
    self:NewTile()
    if self.gunInfo.type ~= CS.GunType.handgun then
        self.textTileType.text = self.gunInfo:GetEffectGridDescription(1)
    end
end
local Initdata = function(self,currentLoadLevel,fairy,fairyInfo,isGet,bookGunInfo)
    -- 确认UI状态为妖精图鉴
    if bookGunInfo == nil and ((fairyInfo ~= nil and fairyInfo.mainSkillName ~= nil) or (fairy ~= nil and fairy.isFriendFairy ~= nil)) then
        if currentLoadLevel == CS.LoadLevel.IllustratedBook and fairy == nil then
            fairy = CS.Fairy(fairyInfo)
            fairy.exp = CS.Data.GetFairyMaxExp();
            fairy._qualityLevel = 5;
            fairy.mainSkillLevel = 10;
        end
        self:Initdata(currentLoadLevel,fairy,fairyInfo,isGet)
    else
        self:Initdata(currentLoadLevel,fairy,fairyInfo,isGet,bookGunInfo)
    end
end
local FormationCharacterStatusController_OnGiveDressFlowEnd = function(self,isConfirmed,isNew)
	self:OnGiveDressFlowEnd(isConfirmed, isNew);
	if isConfirmed then
		self:FavourAndGunData();
	end
end
util.hotfix_ex(CS.FormationCharacterStatusController,'NewTile',NewTile)
util.hotfix_ex(CS.FormationCharacterStatusController,'Initdata',Initdata)
util.hotfix_ex(CS.FormationCharacterStatusController,'OnGiveDressFlowEnd',FormationCharacterStatusController_OnGiveDressFlowEnd)
