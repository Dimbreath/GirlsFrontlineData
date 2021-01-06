local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentUIController)
xlua.private_accessible(CS.DeploymentSangvisSkillPanelController)

function ISTwOrKr()
	return CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Korea or CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Tw;
end

local check = false;
local tipObj;
local get_eyeModeTip = function(self)
	if ISTwOrKr() then
		if check then
			check = false;
			tipObj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("UGUIPrefabs/Deployment/ObservationBG")):GetComponent(typeof(CS.UnityEngine.Transform));
			tipObj:SetParent(self.transform,false);
			tipObj:SetAsFirstSibling();			
		end
		return  tipObj;
	else
		return  self.transform:Find("ObservationBG");
	end
end


local DeploymentUIController_OnClickButton = function(self,Button)
	if CS.DeploymentSangvisSkillPanelController.Instance ~= nil and not CS.DeploymentSangvisSkillPanelController.Instance:isNull() then
		CS.DeploymentSangvisSkillPanelController.Instance:CloseAllSelectTarget();
	end	
	self:OnClickButton(Button);
end

local DeploymentUIController_Awake = function(self)
	if ISTwOrKr() then
		check = true;
		self.transform:Find("ObservationBG").gameObject:SetActive(false);
	else
		for i=0,self.eyeModeTip.childCount -1 do
			local child = self.eyeModeTip:GetChild(i);
			for j=0,child.childCount -1 do
				local image = child:GetChild(j):GetComponent(typeof(CS.ExImage));
				if image ~= nil then
					image.raycastTarget = false;
				end
			end
		end
	end
	self:Awake();
	local tweens = self.transform:Find("Top"):GetComponents(typeof(CS.TweenPlay));
	if tweens ~= nil then
		for i=0,tweens.Length-1 do
			tweens[i].useChild = false;
		end
	end
	
end

util.hotfix_ex(CS.DeploymentUIController,'Awake',DeploymentUIController_Awake)
util.hotfix_ex(CS.DeploymentUIController,'OnClickButton',DeploymentUIController_OnClickButton)
util.hotfix_ex(CS.DeploymentUIController,'get_eyeModeTip',get_eyeModeTip)
