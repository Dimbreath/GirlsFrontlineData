local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSpotController)

local ShowCommonEffect = function(self)
	if self.effect == nil then
		self:ShowCommonEffect();
	end
	if self.effect ~= nil then
		for i=0,self.effect.transform.childCount-1 do
			self.effect.transform:GetChild(i).gameObject:SetActive(true);
		end
	end
end

local UpdateColor = function(self,targetBelong,play)
	self:UpdateColor(targetBelong,play);
	if self.buildControl ~= nil then
		if self:HasFriendlyTeam() then
			self.buildControl.gameObject:SetActive(true);
		else
			self.buildControl.gameObject:SetActive(not self.CannotSee);
		end
	end
	if self.effect ~= nil then
		if self:HasFriendlyTeam() then
			self.effect.gameObject:SetActive(true);
		else
			self.effect.gameObject:SetActive(not self.CannotSee);
		end	
	end
	if self:HasFriendlyTeam() then
		self.gameObject:SetActive(true);
	else
		self.gameObject:SetActive(not self.CannotSee);
	end
	--self:CheckBuild();
end

local CheckPathLine = function(self,play)
	if not self.packageIgnore then
		self:CheckPathLine(play);
	end
end

local Init = function(self)
	self:Init();
	if self.spotAction ~= nil then
		self.spotAction.enemyTeamId = 0;		
	end
end

local CheckBuild = function(self)
	self:CheckBuild();
	if self.buildControl ~= nil then
		self.buildControl:Init();
	end
end

local currentmaplistRoute = function(self)
	self.maproute:Clear();
	for i=0, self.maplistRoute.Count-1 do
		if not self.maplistRoute[i].BelongIgnore or not self.maplistRoute[i].packageIgnore then
			self.maproute:Add(self.maplistRoute[i]);
		end
	end
	return self.maproute;
end

function ShowObj(self)
	local showobj = "";
	local data = self.winTypeid_targetObj:GetEnumerator();
	while data:MoveNext() do		
		local teamData = data.Current.Value;
		teamData:SetActive(false);
		showobj = teamData.name;
		--if showobj == nil then
		--	showobj = teamData;
		--	print("激活"..self.gameObject.name.."/"..teamData.name)
			--teamData:SetActive(true);
		--end
	end
	if showobj ~= "" then
		self.transform:Find(showobj).gameObject:SetActive(true);
	end
end
local ShowWinTarget = function(self,winType,notarget,medal)
	self:ShowWinTarget(winType,notarget,medal);
	ShowObj(self);
end

local CloseWinTarget = function(self,winType)
	if self.winTypeid_targetObj:ContainsKey(winType) then
		if self.winTypeid_targetObj[winType] ~= nil and self.winTypeid_targetObj[winType]:isNull() then
			CS.UnityEngine.Object.Destroy(self.winTypeid_targetObj[winType]);
		end
		self.winTypeid_targetObj:Remove(winType);
	end
	ShowObj(self);
end

local HasFriendlyTeam = function(self)
	if self.currentHostage ~= nil and not self.currentHostage:isNull() then
		return true;
	end
	return self:HasFriendlyTeam();
end
util.hotfix_ex(CS.DeploymentSpotController,'ShowCommonEffect',ShowCommonEffect)
util.hotfix_ex(CS.DeploymentSpotController,'UpdateColor',UpdateColor)
util.hotfix_ex(CS.DeploymentSpotController,'CheckPathLine',CheckPathLine)
util.hotfix_ex(CS.DeploymentSpotController,'Init',Init)
util.hotfix_ex(CS.DeploymentSpotController,'CheckBuild',CheckBuild)
util.hotfix_ex(CS.DeploymentSpotController,'get_currentmaplistRoute',currentmaplistRoute)
util.hotfix_ex(CS.DeploymentSpotController,'ShowWinTarget',ShowWinTarget)
util.hotfix_ex(CS.DeploymentSpotController,'CloseWinTarget',CloseWinTarget)
util.hotfix_ex(CS.DeploymentSpotController,'HasFriendlyTeam',HasFriendlyTeam)
