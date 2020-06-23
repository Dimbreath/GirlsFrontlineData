-- 这个脚本修复2030/2031共通的战区bug
local util = require 'xlua.util'
xlua.private_accessible(CS.RequestTheaterInvestigation)
xlua.private_accessible(CS.TheaterConstructionAction)
xlua.private_accessible(CS.TheaterGainEffectUIController)
xlua.private_accessible(CS.TheaterInvestigationUIController)
xlua.private_accessible(CS.TheaterDetailUIController)
xlua.private_accessible(CS.TheaterRankingUIController)
xlua.private_accessible(CS.GF.Battle.BattleController)
local RequestTheaterInvestigation_SuccessHandleData = function(self,www)
	local before = CS.GameData.GetItem(self.mTheaterSelectionInfo.scout_material);
	self:SuccessHandleData(www);
	local after = CS.GameData.GetItem(self.mTheaterSelectionInfo.scout_material);
	if before ~= after then
		CS.GameData.SetItem(self.mTheaterSelectionInfo.scout_material, before - self.num * self.mTheaterSelectionInfo.scout_material_number);
	end
	before = nil;
	after = nil;
end
local TheaterConstructionAction_GetNextLevelPercent = function(self,lv)
	local cur = CS.GameData.listTheaterConstructionInfo:GetDataById(self.construction_group_id * 100 + lv);
	local next = cur:GetNextLevelConstructionInfo();
	local percent = 0;
	if next ~= nil then
		local curScore = self.pt + self.init_pt - cur.construction_pt;
        local totalScore = next.construction_pt - cur.construction_pt;
        percent = curScore * 1.0 / totalScore;
        cur=nil;
        next=nil;
        return percent;
	else
		cur=nil;
        next=nil;
        percent=nil;
		return 1;
	end	
end
local TheaterConstructionLabelUIController_Init = function(self,theaterConstructionInfo)
	self:Init(theaterConstructionInfo);
	if not self.isUnlock then
		local textLock = self.uiHolder:GetUIElement("Img_OnLock/UI_Text",typeof(CS.ExText));
		if textLock ~= nil then
			textLock.text = CS.System.String.Format(CS.Data.GetLang(210175),theaterConstructionInfo.group_id%10 - 1);
			textLock = nil;
		end
	end
end
local Team_Add = function(self,gun,location,position)
	if location <= self.dictLocation.Count then
		self:Add(gun,location,position);
	else
		print('Team_Add: location out of range');
	end
end
local TheaterGainEffectUIController_ShowConstructionDetails = function(self,theaterConstructionInfo)
	self:ShowConstructionDetails(theaterConstructionInfo);
	local nextInfo = theaterConstructionInfo:GetNextLevelConstructionInfo();
	if nextInfo ~= nil then
		local effectInfo = CS.GameData.listTheaterEffectInfo:GetDataById(nextInfo.effect_id);
        self.mTextNextLevelDescription.text = effectInfo.Description;
        
	end
	local action = CS.GameData.dicTheaterConstructionActions[theaterConstructionInfo.group_id];
	if action ~= nil then
		if action.mCurrentAction ~=nil then 
			local currentPercent = action.mCurrentAction:GetNextLevelPercent(action.lv);
			if currentPercent > 1.0 then
				currentPercent = 1.0;
			end
        	if currentPercent > self.maxRightIndex then
        		self.mImageConstructionCurrentPercent.transform.localPosition = CS.UnityEngine.Vector3(self.mCurrentPercentLocalPositionX, self.mImageConstructionCurrentPercent.transform.localPosition.y, self.mImageConstructionCurrentPercent.transform.localPosition.z);
            	local rightPositionX = -(currentPercent - self.maxRightIndex) * self.currentProgressWidth;
            	self.mImageConstructionCurrentPercent.transform.localPosition = CS.UnityEngine.Vector3(self.mImageConstructionCurrentPercent.transform.localPosition.x + rightPositionX, self.mImageConstructionCurrentPercent.transform.localPosition.y, self.mImageConstructionCurrentPercent.transform.localPosition.z);
        	end
        	currentPercent = nil;	
		end	
	end	
	nextInfo=nil;
	action=nil;
end
local TheaterInvestigationUIController_SetSPYResult = function(self)
	self:SetSPYResult();
	local percent = self.mTextResultGain.text;
	if self.lastTheaterIncidentInvestigationAction ~=nil then
		local selectIncidentInfo = CS.GameData.listTheaterIncidentInfo:GetDataById(self.lastTheaterIncidentInvestigationAction.incident_id);
		local manority =selectIncidentInfo.scout_manority_coef;
		local majority =selectIncidentInfo.scout_majority_coef;
		if percent == tostring(majority)..'%' then
			self.mTextActionDetail.text = CS.Data.GetLang(210168);
        	self.mTextPersonNumberTips.text = CS.Data.GetLang(210169);	
    	end		 
    	if percent == tostring(manority)..'%' then  
    		self.mTextActionDetail.text = CS.Data.GetLang(210167);
        	self.mTextPersonNumberTips.text = CS.Data.GetLang(210170);	
		end
		percent=nil;
		selectIncidentInfo=nil;
		manority=nil;
		majority=nil;
	end
end
local TheaterDetailUIController_Init = function(self,info)
	self:Init(info);
	local theaterEventInfo = CS.GameData.listTheaterEventInfo:GetDataById(info.theater_event_id);
    local coreInfo = CS.GameData.listTheaterInfo:GetDataById(theaterEventInfo.core_theater);
	if info == coreInfo then
		local imgIcon = self.uiHolder:GetUIElement("TileInfo/Img_Icon",typeof(CS.ExImage));
		if imgIcon ~= nil then
			imgIcon.color = CS.UnityEngine.Color.red;
			imgIcon = nil;
		end
		theaterEventInfo=nil;
		coreInfo=nil;
	end
end
local TheaterInfo_get_rankName = function(self)
	if self.rank==4 then
		return CS.Data.GetLang(210056);	
	else
		return self.rankName;
	end
end
local BattleController_RequestTheaterNormalBattle = function(self)
	local team = CS.GameData.dictTeam[self.currentSpotAction.friendlyTeamId];
	if team.fairy ~= nil then
		team.fairy.waitForConsume = false;
		CS.Fairy.ClearFairySkillState();
	end
	self:RequestTheaterNormalBattle();
end
local TheaterInvestigationUIController_ShowSPYResult = function(self,b)
	local day = CS.TheaterInvestigationUIController.Instance.currentDayCount;
	if  day > 1 then	
		self:ShowSPYResult(b);
	else
		CS.TheaterInvestigationUIController.Instance.mButtonLastResult.gameObject:SetActive(false);
		CS.TheaterInvestigationUIController.Instance.mShowLastResult = false;
		self:ShowSPYResult(false);
	end 
end
local TheaterRankingUIController_DefaultRequestFinalRankData = function(self)
	CS.TheaterRankingUIController.Instance.currentActivityIsEnd = true;
	self:DefaultRequestFinalRankData(); 
end
util.hotfix_ex(CS.RequestTheaterInvestigation,'SuccessHandleData',RequestTheaterInvestigation_SuccessHandleData)
util.hotfix_ex(CS.TheaterConstructionAction,'GetNextLevelPercent',TheaterConstructionAction_GetNextLevelPercent)
util.hotfix_ex(CS.TheaterInvestigationUIController,'SetSPYResult',TheaterInvestigationUIController_SetSPYResult)
util.hotfix_ex(CS.TheaterGainEffectUIController,'ShowConstructionDetails',TheaterGainEffectUIController_ShowConstructionDetails)
util.hotfix_ex(CS.TheaterConstructionLabelUIController,'Init',TheaterConstructionLabelUIController_Init)
util.hotfix_ex(CS.GF.Battle.Team,'Add',Team_Add)
util.hotfix_ex(CS.TheaterDetailUIController,'Init',TheaterDetailUIController_Init)
util.hotfix_ex(CS.TheaterInfo,'get_rankName',TheaterInfo_get_rankName)
util.hotfix_ex(CS.GF.Battle.BattleController,'RequestTheaterNormalBattle',BattleController_RequestTheaterNormalBattle)
util.hotfix_ex(CS.TheaterInvestigationUIController,'ShowSPYResult',TheaterInvestigationUIController_ShowSPYResult)
util.hotfix_ex(CS.TheaterRankingUIController,'DefaultRequestFinalRankData',TheaterRankingUIController_DefaultRequestFinalRankData)