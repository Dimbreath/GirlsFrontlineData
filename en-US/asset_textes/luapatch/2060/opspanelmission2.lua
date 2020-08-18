local util = require 'xlua.util'
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
	--print(self.order);
	if self.order == 0 or self.order == 6 then
		for i=0,self.transform.childCount-1 do
			self.transform:GetChild(i).gameObject:SetActive(false);
		end
		self.transform:Find("2").gameObject:SetActive(true);
		self.transform:Find("2/Tex_LevelName"):GetComponent(typeof(CS.ExText)).text = self.currentMission.missionInfo.name;
								
	elseif self.order > 6 and self.order < 12 then
		for i=0,self.transform.childCount-1 do
			self.transform:GetChild(i).gameObject:SetActive(false);
		end
		self.transform:Find("1").gameObject:SetActive(true);
		self.transform:Find("1/Tex_CptNum"):GetComponent(typeof(CS.ExText)).text = self.holder.order;
		self.transform:Find("1/Tex_LevelName"):GetComponent(typeof(CS.ExText)).text = self.currentMission.missionInfo.name;
		self.transform:Find("1/UnlocksProgress").gameObject:SetActive(self.currentMission.clocked);
		self.transform:Find("1/BattleNode").gameObject:SetActive(CS.GameData.missionAction ~= nil and CS.GameData.missionAction == self.currentMission);
		if self.currentMission ~= nil and not CS.System.String.IsNullOrEmpty(self.currentMission.missionInfo.drop_key_info) then
			self.clockCheck.gameObject:SetActive(true);
			self:CheckDropMissionkeyInfo(self.transform:Find("1/UnlocksProgress/Tex_Progress"));
		end
	else
		for i=0,self.transform.childCount-1 do
			self.transform:GetChild(i).gameObject:SetActive(true);
		end
		self.transform:Find("UnlocksProgress").gameObject:SetActive(self.currentMission.clocked);
		self.transform:Find("BattleNode").gameObject:SetActive(CS.GameData.missionAction ~= nil and CS.GameData.missionAction == self.currentMission);		
		self.transform:Find("1").gameObject:SetActive(false);
		self.transform:Find("2").gameObject:SetActive(false);
		if self.currentMission ~= nil and not CS.System.String.IsNullOrEmpty(self.currentMission.missionInfo.drop_key_info) then
			self.clockCheck.gameObject:SetActive(true);
			self:CheckDropMissionkeyInfo(self.clockText);
		end
	end
end

util.hotfix_ex(CS.OPSPanelMission2,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelMission2,'RefreshUI',RefreshUI)