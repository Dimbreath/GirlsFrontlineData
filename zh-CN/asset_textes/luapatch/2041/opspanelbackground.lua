local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelBackGround)
xlua.private_accessible(CS.OPSPanelController)
	
local OPSPanelBackGround_InitMap = function(self)
	self:InitMap();
	local background = CS.OPSPanelController.Instance.background.transform;
	if background ~= nil then
		local child = background.transform:Find(tostring(CS.OPSPanelBackGround.currentContainerId));
		if child ~= nil then			
			for  i = 0, background.childCount-1 do
				local tweenPlay = background:GetChild(i):GetComponent(typeof(CS.TweenPlay));
				if tweenPlay~= nil then
					tweenPlay.EnbleSetValue = false;
					tweenPlay.disbleSetValue = false;
					tweenPlay.playStartFromValue = false;
					tweenPlay.isPlayBackwards = background:GetChild(i) ~= child;
				end
				if background:GetChild(i) == child then
					child.gameObject:SetActive(false);
					child.gameObject:SetActive(true);
				else
					if background:GetChild(i).gameObject.activeSelf then
						background:GetChild(i).gameObject:SetActive(false);
						background:GetChild(i).gameObject:SetActive(true);
					end
				end
			end						
		end
	end
end

local OPSPanelBackGround_UpdateScalePos = function(self,updatepos,updatescale)
	self:UpdateScalePos(updatepos,updatescale);
	local child = CS.OPSPanelController.Instance.background.transform:Find(tostring(CS.OPSPanelBackGround.currentContainerId));
	if CS.OPSPanelBackGround.currentContainerId ~= 0 and child ~= nil  then
		child:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = self.targetPosition * 0.1;
	end
end
	
util.hotfix_ex(CS.OPSPanelBackGround,'InitMap',OPSPanelBackGround_InitMap)
util.hotfix_ex(CS.OPSPanelBackGround,'UpdateScalePos',OPSPanelBackGround_UpdateScalePos)