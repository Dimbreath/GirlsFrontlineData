local util = require 'xlua.util'
xlua.private_accessible(CS.DormSwapRoomSelectionList)
local Init = function(self)
	if self.hasInit then
		return;
	end
	local prefab = self.gobjPrefab;
	prefab = nil; -- 取值一次，为了保证有缓存。下面的代码会导致UI层级变化，未缓存时会出错
	prefab = self.toggleGroup;
	prefab = nil;
	self.listRooms = CS.System.Collections.Generic.List(CS.UnityEngine.RectTransform)();
	local tempGO = CS.UnityEngine.GameObject("ScrollRect");
	tempGO.transform:SetParent(self.transform, false);
	local rectTemp = tempGO:AddComponent(typeof(CS.UnityEngine.RectTransform));
	rectTemp.pivot = CS.UnityEngine.Vector2(1,0);
	rectTemp.anchorMin = CS.UnityEngine.Vector2(1,0);
	rectTemp.anchorMax = CS.UnityEngine.Vector2(1,1);
	rectTemp.offsetMin = CS.UnityEngine.Vector2(0,200);
	rectTemp.offsetMax = CS.UnityEngine.Vector2(0,-200);
	rectTemp:SetSizeWithCurrentAnchors(CS.UnityEngine.RectTransform.Axis.Horizontal,300);
	local transformParent = self.transformContainer;
	transformParent:SetParent(rectTemp, false);
	local scroll = tempGO:AddComponent(typeof(CS.UnityEngine.UI.ScrollRect));;
	scroll.content = transformParent;
	scroll.viewport = rectTemp;
	scroll.horizontal = false;
	tempGO = nil;
	rectTemp = nil;
	scroll = nil;
	local fitter = transformParent.gameObject:AddComponent(typeof(CS.UnityEngine.UI.ContentSizeFitter));
	fitter.verticalFit = CS.UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize;
	fitter = nil;
	local grid = transformParent.gameObject:AddComponent(typeof(CS.UnityEngine.UI.GridLayoutGroup));
	grid.cellSize = CS.UnityEngine.Vector2(297,90);
	grid.spacing = CS.UnityEngine.Vector2(0,-11);
	grid = nil;
	self:Init();
end
local Open = function(self)
	self:Init();
	local count = self.listRooms.Count;
	for i = 0, count-1 do
		self.listRooms[i].gameObject:SetActive(true);
		self.listRooms[i].anchoredPosition = CS.UnityEngine.Vector2(0, (count - i)*68);
		CS.UITweenManager.PlayFadeTweens(self.listRooms[i], 0, 1, 0.5);
	end
	self.transformContainer.anchoredPosition = CS.UnityEngine.Vector2(-180,-1000);
	
	CS.CommonController.Invoke(function()
			self.isOpen = true;
		end, 0.5, self);
end
local Close = function(self)
	if not self.isOpen then
		return;
	end
	local count = self.listRooms.Count;
	for i = 0, count-1 do
		CS.UITweenManager.PlayFadeTweens(self.listRooms[i], 1, 0, 0.5);
	end
	CS.CommonController.Invoke(function()
			self.isOpen = false;
			local count = self.listRooms.Count;
			for i = 0, count-1 do
				self.listRooms[i].gameObject:SetActive(false);
			end
		end, 0.5, self);
end
util.hotfix_ex(CS.DormSwapRoomSelectionList,'Init',Init)
util.hotfix_ex(CS.DormSwapRoomSelectionList,'Open',Open)
util.hotfix_ex(CS.DormSwapRoomSelectionList,'Close',Close)