local util = require 'xlua.util'
local panelController = require("2060/OPSPanelController")
xlua.private_accessible(CS.OPSPanelMission2)

local Awake = function(self)
	self:Awake();
	self.transform:Find("1/Img_Bottom"):GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
			self:Click();
		end)
	self.transform:Find("2/Img_Bottom"):GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
			self:Click();
		end)
end

local RefreshUI = function(self)
	self:RefreshUI();
	local iter = CS.GameData.missionKeyNum:GetEnumerator();
	while iter:MoveNext() do
		local key = iter.Current.Key;
		local num = iter.Current.Value;
		if not CS.SpecialActivityController.missionkey_num:ContainsKey(key) then
			CS.SpecialActivityController.missionkey_num:Add(key,num);
		else
			CS.SpecialActivityController.missionkey_num[key] = num;
		end
	end

	if self.currentMission == nil then
		return;
	end
	if CS.OPSPanelController.Instance.campaionId == -41 then
		if self.order == 0 or self.order == 6 or (self.order>19 and self.order<24)then
			Show2(self);				
		elseif self.order > 6 and self.order < 12 then
			Show1(self);
		else
			ShowSelf(self);
		end
		return;
	end
	if CS.OPSPanelController.Instance.campaionId == -43 then
		if self.order > 5 and self.order < 12 then
			Show1(self);
		else
			ShowSelf(self);
		end
		return;
	end
	--print(self.order);		
	if spotInfo[self.order] ~= nil then
		if spotInfo[self.order][2] == 1 then
			for i=0,self.transform.childCount-1 do
				self.transform:GetChild(i).gameObject:SetActive(false);
			end
			self.transform:Find("1").gameObject:SetActive(true);
			local num = self.holder.order-6+0.1;
			self.transform:Find("1/Tex_CptNum"):GetComponent(typeof(CS.ExText)).text = tostring(num);
			self.transform:Find("1/Tex_LevelName"):GetComponent(typeof(CS.ExText)).text = self.currentMission.missionInfo.name;
			self.transform:Find("1/UnlocksProgress").gameObject:SetActive(self.currentMission.clocked);
			self.transform:Find("1/BattleNode").gameObject:SetActive(CS.GameData.missionAction ~= nil and CS.GameData.missionAction.missionInfo.id == self.currentMission.missionInfo.id);
			if self.currentMission ~= nil and not CS.System.String.IsNullOrEmpty(self.currentMission.missionInfo.drop_key_info) then
				self.clockCheck.gameObject:SetActive(true);
				self:CheckDropMissionkeyInfo(self.transform:Find("1/UnlocksProgress/Tex_Progress"));
			end
		elseif spotInfo[self.order][2] == 2 then
			for i=0,self.transform.childCount-1 do
				self.transform:GetChild(i).gameObject:SetActive(false);
			end
			self.transform:Find("2").gameObject:SetActive(true);
			self.transform:Find("2/Tex_LevelName"):GetComponent(typeof(CS.ExText)).text = self.currentMission.missionInfo.name;
		else
			for i=0,self.transform.childCount-1 do
				self.transform:GetChild(i).gameObject:SetActive(true);
			end
			self.transform:Find("UnlocksProgress").gameObject:SetActive(self.currentMission.clocked);
			self.transform:Find("BattleNode").gameObject:SetActive(CS.GameData.missionAction ~= nil and CS.GameData.missionAction.missionInfo.id == self.currentMission.missionInfo.id);		
			self.transform:Find("1").gameObject:SetActive(false);
			self.transform:Find("2").gameObject:SetActive(false);
			if self.currentMission ~= nil and not CS.System.String.IsNullOrEmpty(self.currentMission.missionInfo.drop_key_info) then
				self.clockCheck.gameObject:SetActive(true);
				self:CheckDropMissionkeyInfo(self.clockText);
			end
			self.transform:Find("Tex_CptNum"):GetComponent(typeof(CS.ExText)).text = spotInfo[self.order][1];

			--if self.order > 16 and self.order < 20 then
			--	self.transform:Find("Tex_CptNum/Img_Chapter"):GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2060/abyss");
			--end
		end
	end	

end

function ShowSelf(self)
	for i=0,self.transform.childCount-1 do
		self.transform:GetChild(i).gameObject:SetActive(true);
	end
	self.transform:Find("UnlocksProgress").gameObject:SetActive(self.currentMission.clocked);
	self.transform:Find("BattleNode").gameObject:SetActive(CS.GameData.missionAction ~= nil and CS.GameData.missionAction.missionInfo.id == self.currentMission.missionInfo.id);		
	self.transform:Find("1").gameObject:SetActive(false);
	self.transform:Find("2").gameObject:SetActive(false);
	if self.currentMission ~= nil and not CS.System.String.IsNullOrEmpty(self.currentMission.missionInfo.drop_key_info) then
		self.clockCheck.gameObject:SetActive(true);
		self:CheckDropMissionkeyInfo(self.clockText);
	end
	if self.order > 11 and self.order < 17 then
		local num = self.order-11;
		self.transform:Find("Tex_CptNum"):GetComponent(typeof(CS.ExText)).text = tostring(num);
	end
	if self.order > 16 and self.order < 20 then
		local num = (self.order-16);
		self.transform:Find("Tex_CptNum/Img_Chapter"):GetComponent(typeof(CS.ExImage)).sprite = CS.CommonController.LoadPngCreateSprite("AtlasClips2060/abyss");
		self.transform:Find("Tex_CptNum"):GetComponent(typeof(CS.ExText)).text = tostring(num);
	end
end

function Show1(self)
	for i=0,self.transform.childCount-1 do
		self.transform:GetChild(i).gameObject:SetActive(false);
	end
	self.transform:Find("1").gameObject:SetActive(true);
	local num = self.holder.order-6+0.1;
	if CS.OPSPanelController.Instance.campaionId == -43 then
		num = self.holder.order-5+0.1;
		if self.holder.order == 11 then
			num = 5.2;
		end
	end
	self.transform:Find("1/Tex_CptNum"):GetComponent(typeof(CS.ExText)).text = tostring(num);
	self.transform:Find("1/Tex_LevelName"):GetComponent(typeof(CS.ExText)).text = self.currentMission.missionInfo.name;
	self.transform:Find("1/UnlocksProgress").gameObject:SetActive(self.currentMission.clocked);
	self.transform:Find("1/BattleNode").gameObject:SetActive(CS.GameData.missionAction ~= nil and CS.GameData.missionAction.missionInfo.id == self.currentMission.missionInfo.id);
	if self.currentMission ~= nil and not CS.System.String.IsNullOrEmpty(self.currentMission.missionInfo.drop_key_info) then
		self.clockCheck.gameObject:SetActive(true);
		self:CheckDropMissionkeyInfo(self.transform:Find("1/UnlocksProgress/Tex_Progress"));
	end
end

function Show2(self)
	for i=0,self.transform.childCount-1 do
		self.transform:GetChild(i).gameObject:SetActive(false);
	end
	self.transform:Find("2").gameObject:SetActive(true);
	self.transform:Find("2/Tex_LevelName"):GetComponent(typeof(CS.ExText)).text = self.currentMission.missionInfo.name;
end

util.hotfix_ex(CS.OPSPanelMission2,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelMission2,'RefreshUI',RefreshUI)