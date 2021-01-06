local util = require 'xlua.util'
xlua.private_accessible(CS.BattleSangvisResultController)
xlua.private_accessible(CS.SangvisGun)
local GetSpineCode = function(self)
	return self:GetPicCode()
end

local ExpToLevelSangvis = function(sangvisExp)
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
local ShowLeaderInfo = function(self,gun)
	xlua.hotfix(CS.SangvisGun,"GetSpineCode",GetSpineCode)
	self:ShowLeaderInfo(gun)
	xlua.hotfix(CS.SangvisGun,"GetSpineCode",nil)
	if CS.GameData.listSangvisGun:Contains(gun) then
		self.currentLevel = ExpToLevelSangvis(gun.experience - self.getExp)
		self.Tex_CaptainLevel.text = tostring(self.currentLevel)
	end
	self.objLevelUp:SetActive(false)
end

local UpdateExpUILerp = function(self)
	local CaptainGun = self.CaptainGun
	local expToNextLevel = CS.GameData.SangvisLevelToSumExp(self.currentLevel) - (CaptainGun.experience - self.getExp)
	if expToNextLevel <= 0  then
		self.currentLevel = ExpToLevelSangvis(CaptainGun.experience - self.getExp)
		expToNextLevel = CS.GameData.SangvisLevelToSumExp(self.currentLevel) - (CaptainGun.experience - self.getExp)
		self.Tex_CaptainLevel.text = tostring(CaptainGun.level)
		self.Tex_CaptainHP.text = CS.System.String.Format("<Color=#D3E05CFF>{0}</Color>/{1}",tostring(CaptainGun.life),tostring(CaptainGun.maxLife))
		self.objLevelUp:SetActive(true)
		CS.CommonAudioController.PlayUI(CS.AudioUI.UI_LevelUp)
	end
	self.Tex_CaptainExpNext.text = tostring(expToNextLevel)
	local currentLevelMinExpSum = CS.GameData.SangvisLevelToSumExp(self.currentLevel-1)
	local currentLevelExp = (CaptainGun.experience - self.getExp) - currentLevelMinExpSum
	local currentLevelMaxExp = CS.GameData.CurrentSangvisLeveMaxExp(self.currentLevel)
	self.Img_Exp.fillAmount = (currentLevelExp) / currentLevelMaxExp
	self.Img_Add.fillAmount = (currentLevelExp) / currentLevelMaxExp
end
local Init = function(self,...)
	self:Init(...);
	if (self.battleController ~= nil) then
		self.textEnemyDie.text = CS.System.String.Format(CS.Data.GetLang(10147), tostring(self.battleController.statistics.enemyDieNumber));
		self.textFriendlyDie.text = CS.System.String.Format(CS.Data.GetLang(10148), tostring(self.battleController.statistics.friendlyDieNumber));
	end
end
util.hotfix_ex(CS.BattleSangvisResultController,'ShowLeaderInfo',ShowLeaderInfo)
xlua.hotfix(CS.BattleSangvisResultController,'UpdateExpUILerp',UpdateExpUILerp)
util.hotfix_ex(CS.BattleSangvisResultController,'Init',Init)