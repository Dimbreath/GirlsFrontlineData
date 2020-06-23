local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchSkillChoosePanle)
local InitUIElements = function(self)
	self:InitUIElements();
	print('ResearchSkillChoosePanle');
	local textParent = self.uiHolder:GetUIElement("技能/Text提升", typeof(CS.UnityEngine.GameObject));
	local scrollRect = textParent:AddComponent(typeof(CS.UnityEngine.UI.ScrollRect));
	scrollRect.content = self.textSkillDetail.rectTransform;
	scrollRect.horizontal = false;
	local image = textParent:AddComponent(typeof(CS.ExImage));
	image.color = CS.UnityEngine.Color(1,1,1,0);
	textParent:AddComponent(typeof(CS.UnityEngine.UI.RectMask2D));
	textParent.transform.anchoredPosition = CS.UnityEngine.Vector2(261, 3.6);
	textParent.transform.sizeDelta = CS.UnityEngine.Vector2(395, 335.3);
	self.textSkillDetail.resizeTextMinSize = 26;
	self.textSkillDetail.rectTransform.pivot = CS.UnityEngine.Vector2(0, 1);
	self.textSkillDetail.rectTransform.anchoredPosition = CS.UnityEngine.Vector2(-199,-100);
	local fitter = self.textSkillDetail.gameObject:AddComponent(typeof(CS.UnityEngine.UI.ContentSizeFitter));
	fitter.verticalFit = CS.UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize;

	textParent = nil;
	scrollRect = nil;
	image = nil;
	fitter = nil;
end
util.hotfix_ex(CS.ResearchSkillChoosePanle,'InitUIElements',InitUIElements)