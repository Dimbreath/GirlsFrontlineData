local util = require 'xlua.util'
xlua.private_accessible(CS.Joystick)
local Tran_JoyStick
local Start = function(self)
	self:Start()
	Tran_JoyStick = self.transform:Find('Img_JoyStick'):GetComponent(typeof(CS.UnityEngine.RectTransform))
	self.content.gameObject:SetActive(true)
	self.mRadius =  80
end
local OnDrag = function(self,eventData)
	
	self:OnDrag(eventData)
	Tran_JoyStick.localPosition = self.content:GetComponent(typeof(CS.UnityEngine.RectTransform)).localPosition / 2
	--UI的 canvas 有个22度的倾角
	self.content.eulerAngles = CS.UnityEngine.Vector3(22,self.content.eulerAngles.y,self.content.eulerAngles.z)
end
local OnEndDrag = function(self,eventData)
	self:OnEndDrag(eventData)
	self.content.gameObject:SetActive(true)
	Tran_JoyStick.localPosition = CS.UnityEngine.Vector3.zero	
end
util.hotfix_ex(CS.Joystick,'OnDrag',OnDrag)
util.hotfix_ex(CS.Joystick,'OnEndDrag',OnEndDrag)
util.hotfix_ex(CS.Joystick,'Start',Start)
