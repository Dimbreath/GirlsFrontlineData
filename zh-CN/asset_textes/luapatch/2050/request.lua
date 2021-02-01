local util = require 'xlua.util'
xlua.private_accessible(CS.RequestSangvisGashaDraw)
xlua.private_accessible(CS.RequestSangvisGasha)
xlua.private_accessible(CS.RequestSangvisResetGasha)
xlua.private_accessible(CS.RequestSangvisRefreshGasha)
xlua.private_accessible(CS.RequestRecoverGasha)
xlua.private_accessible(CS.RequestSangvisTransfer)
xlua.private_accessible(CS.Package)
xlua.private_accessible(CS.RequestGunApplySangvisTeamRecord)
local mySuccessHandleData = function(self,www)
    if www.text == "error:204"then
         CS.CommonController.MessageBox(CS.Data.GetLang(260070), function() CS.CommonController.GotoScene("Home"); end);
    elseif www.text == "error:205" then
		CS.CommonController.MessageBox(CS.Data.GetLang(70024), function() CS.CommonController.GotoScene("Home"); end);
	else
		self:SuccessHandleData(www)
	end
end
local mySuccessHandleDataDeleteDynamicData = function(self,www)
    if www.text == "error:204"then
        CS.CommonController.MessageBox(CS.Data.GetLang(260070), function() CS.CommonController.GotoScene("Home"); end);
    elseif www.text == "error:205" then
		CS.CommonController.MessageBox(CS.Data.GetLang(70024), function() CS.CommonController.GotoScene("Home"); end);
	else
		self:SuccessHandleData(www)
		for i = CS.GameData.sangvisDynamicEventInfoList.Count - 1, 0, -1 do
		-- 移除还没开始的  跟已经结束了的
			if(CS.GameData.sangvisDynamicEventInfoList[i].start_time > CS.GameData.GetCurrentTimeStamp()) and (CS.GameData.sangvisDynamicEventInfoList[i].end_time < CS.GameData.GetCurrentTimeStamp()) then
				CS.GameData.sangvisDynamicEventInfoList:RemoveAt(i);
			end
		end
	end
end
local myRequestSangvisGashaDrawSuccessHandle = function(self,www)
    mySuccessHandleDataDeleteDynamicData(self, www);
	local count = self.resultPackageList.Count;
	for i = 0, count - 1, 1 do
		self.resultPackageList[i]:GetPackage("SangvisCapture");
	end
end
local mySuccessHandleDataSangvisTransfer = function (self,www)
	if CS.ConnectionController.CheckONE(www.text) then
		local sangvisLeft = CS.GameData.listSangvisGun:GetDataById(self.sangvis_with_user_id_from);
		local sangvisRight = CS.GameData.listSangvisGun:GetDataById(self.sangvis_with_user_id_to);
		local transferCore = CS.GameData.GetItem(self.coreId);
		CS.GameData.SetItem(self.coreId,transferCore - self.coreNum);
		local level = sangvisLeft.level;
		local sangvisExp = sangvisLeft.experience;
		local sangvisResolution = sangvisLeft.resolutionValue;
		local life = sangvisLeft.life;
		local resolutionLevel = sangvisLeft.resolutionLevel;
		local advance = sangvisLeft.advance;
		local favor = sangvisLeft.favor;
		sangvisLeft.level = sangvisRight.level;
		sangvisLeft.experience = sangvisRight.experience;
		sangvisLeft.resolutionValue = sangvisRight.resolutionValue;
		sangvisLeft.life = sangvisRight.life;
		sangvisLeft.resolutionLevel = sangvisRight.resolutionLevel;
		local skillAdvanceLevel = sangvisLeft:GetSangvisGunSkillInfo(4).skillLevel;
		sangvisLeft.advance = sangvisRight.advance;
		sangvisLeft.favor = sangvisRight.favor;
		sangvisRight.level = level;
		sangvisRight.experience = sangvisExp;
		sangvisRight.resolutionValue = sangvisResolution;
		sangvisRight.life = life;
		sangvisRight.resolutionLevel = resolutionLevel;
		sangvisRight.advance = advance;
		sangvisRight.favor = favor;
		sangvisLeft:GetSangvisGunSkillInfo(4).skillLevel = sangvisRight:GetSangvisGunSkillInfo(4).skillLevel;
		sangvisRight:GetSangvisGunSkillInfo(4).skillLevel = skillAdvanceLevel;
		local skill3Level = sangvisLeft:GetSangvisGunSkillInfo(3).skillLevel;
		sangvisLeft:GetSangvisGunSkillInfo(3).skillLevel = sangvisRight:GetSangvisGunSkillInfo(3).skillLevel;
		sangvisRight:GetSangvisGunSkillInfo(3).skillLevel = skill3Level;
	end
end
local mySuccessHandleDataGunApplySangvisTeamRecord = function (self,www)
	self:SuccessHandleData(www);
	if CS.ConnectionController.CheckONE(www.text) then
		local con = CS.GameData.dictTeamFairy:ContainsKey(self.teamId);
		if con then
			CS.GameData.dictTeamFairy[self.teamId].teamId =0;
			CS.GameData.dictTeamFairy:Remove(self.teamId);
		end
	end
end

util.hotfix_ex(CS.RequestSangvisGashaDraw,'SuccessHandleData',myRequestSangvisGashaDrawSuccessHandle)
util.hotfix_ex(CS.RequestSangvisGasha,'SuccessHandleData',mySuccessHandleDataDeleteDynamicData)
util.hotfix_ex(CS.RequestSangvisResetGasha,'SuccessHandleData',mySuccessHandleData)
util.hotfix_ex(CS.RequestSangvisRefreshGasha,'SuccessHandleData',mySuccessHandleData)
util.hotfix_ex(CS.RequestRecoverGasha,'SuccessHandleData',mySuccessHandleDataDeleteDynamicData)
util.hotfix_ex(CS.RequestSangvisTransfer,'SuccessHandleData',mySuccessHandleDataSangvisTransfer)
util.hotfix_ex(CS.RequestGunApplySangvisTeamRecord,'SuccessHandleData',mySuccessHandleDataGunApplySangvisTeamRecord)