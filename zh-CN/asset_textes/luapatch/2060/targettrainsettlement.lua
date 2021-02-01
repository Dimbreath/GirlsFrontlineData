local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainSettlement)

local InitByRecord = function(self,data,name)
	self.transform:SetParent(null,false)
	self.gameObject:GetComponent(typeof(CS.UnityEngine.Canvas)).renderMode = CS.UnityEngine.RenderMode.ScreenSpaceCamera
	self.transform:Find("Main/LeftInfoGroup").gameObject:GetComponent(typeof(CS.TweenPlay)).enabled = false
	self.transform:Find("Main/LeftInfoGroup").gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = CS.UnityEngine.Vector2(353.95,0)
	self.BtnBack.gameObject:GetComponent(typeof(CS.TweenPlay)).enabled = false
	self.BtnBack.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = CS.UnityEngine.Vector2(0,0)
	self:InitByRecord(data,name)
end
util.hotfix_ex(CS.TargetTrainSettlement,'InitByRecord',InitByRecord)