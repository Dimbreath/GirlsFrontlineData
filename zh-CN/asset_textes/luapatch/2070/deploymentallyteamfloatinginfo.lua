local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamFloatingInfo)

local hasmanual = false;
local RefreshBuffUI = function(self)	
	hasmanual = false;
	if self.allyTeamController == nil then
		return;
	end
	if not self.useenemyUI then
		for i=0,self.allyTeamController.allListBuffAction.Count-1 do
			local buff = self.allyTeamController.allListBuffAction[i];
			if CS.GameData.missionAction ~= nil and not CS.GameData.missionAction.playBuffAction:Contains(buff) then
				if not CS.System.String.IsNullOrEmpty(buff.missionBuffInfo.manulcode) then
					hasmanual = true;
					self.allyUITransform.transform:Find("SavingNode").gameObject:SetActive(true);
					if buff.iconObj == nil or buff.iconObj:isNull() then
						local iconparent = self.allyUITransform.transform:Find("SavingNode/IconType");
						iconparent:GetChild(0).gameObject:SetActive(self.hostageHp>0);
						buff.iconObj = CS.UnityEngine.GameObject.Instantiate(iconparent:GetChild(0).gameObject);
						buff.iconObj.transform:SetParent(iconparent,false);
						buff.iconObj.transform:SetAsLastSibling();
						buff.iconObj:SetActive(true);
						local image = buff.iconObj:GetComponent(typeof(CS.ExImage));
						image.sprite = CS.CommonController.LoadPngCreateSprite("Pics/Icons/Skill/Deployment/"..buff.missionBuffInfo.manulcode);
					end
					if buff.nameObj == nil or buff.nameObj:isNull() then
						local nameparent = self.allyUITransform.transform:Find("SavingNode/SavingTagList");
						nameparent:GetChild(0).gameObject:SetActive(self.hostageHp>0);
						buff.nameObj = CS.UnityEngine.GameObject.Instantiate(nameparent:GetChild(0).gameObject);
						buff.nameObj.transform:SetParent(nameparent,false);
						buff.nameObj.transform:SetAsLastSibling();
						buff.nameObj:SetActive(true);
						local image = buff.nameObj:GetComponent(typeof(CS.UnityEngine.UI.Image));
						image.color = buff.missionBuffInfo.manulColor;
						local text = buff.nameObj.transform:Find("Text_Saving"):GetComponent(typeof(CS.ExText));
						text.text = buff.missionBuffInfo.description;
					end
				end
			end
		end
	end
	local buffs = {}
	for i=0,self.allyTeamController.currentListBuffAction.Count-1 do
		local buff = self.allyTeamController.currentListBuffAction[i];
		if not CS.System.String.IsNullOrEmpty(buff.missionBuffInfo.manulcode) then
			table.insert(buffs,buff);
		end
	end
	for i=1, #buffs do
		self.allyTeamController.currentListBuffAction:Remove(buffs[i]);
	end
	self:RefreshBuffUI();
	for i=1, #buffs do
		self.allyTeamController.currentListBuffAction:Add(buffs[i]);
	end
end

local UpdateInfo = function(self)
	self:UpdateInfo();
	if hasmanual or self.hostageHp>0 then
		self.SaveNode.gameObject:SetActive(true);
		self.SaveNode:Find("IconType/Image_Icon").gameObject:SetActive(self.hostageHp>0);
		self.SaveNode:Find("SavingTagList/Image_SavingTag").gameObject:SetActive(self.hostageHp>0);
	else
		self.SaveNode.gameObject:SetActive(false);
	end
end
local CheckPoint = function(self)
	local point = self.allyTeamController.allyTeam:CurrentPower(self.allyTeamController.currentSpot);
	if self.power == point then
		self.txtEnemyTeam.text = tostring(point);
		self.txtAllyPoint.text = tostring(point);
	end
	self:CheckPoint();
end
util.hotfix_ex(CS.DeploymentAllyTeamFloatingInfo,'RefreshBuffUI',RefreshBuffUI)
util.hotfix_ex(CS.DeploymentAllyTeamFloatingInfo,'UpdateInfo',UpdateInfo)
util.hotfix_ex(CS.DeploymentAllyTeamFloatingInfo,'CheckPoint',CheckPoint)

