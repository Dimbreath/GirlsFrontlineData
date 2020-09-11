local util = require 'xlua.util'
xlua.private_accessible(CS.TipOpenManualBoxBtnController)
local myOnClickOpenManual = function(self)
	if(self.griffinManualBox == nil or self.griffinManualBox:isNull()) then
		self.griffinManualBox = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("UGUIPrefabs/GriffinEntryManual/GriffinManualBox"));
        local messageBoxCanvas = CS.UnityEngine.GameObject.Find("MessageboxCanvas"):GetComponent(typeof(CS.UnityEngine.Canvas));
        messageBoxCanvas.sortingOrder = 2;
        messageBoxCanvas.worldCamera = CS.UnityEngine.GameObject.Find("MessageBoxCamera"):GetComponent(typeof(CS.UnityEngine.Camera));
        self.griffinManualBox.transform:SetParent(messageBoxCanvas.transform, false);
	end
	self:OnClickOpenManual();
end
util.hotfix_ex(CS.TipOpenManualBoxBtnController,'OnClickOpenManual',myOnClickOpenManual)