local util = require 'xlua.util'
xlua.private_accessible(CS.OPSRuler)

local OPSRuler_InitUnclockTime = function(self,time)
	self:InitUnclockTime(time);
	if self.timeBoard ~= nil and  not self.timeBoard:isNull() then
		local texttip = self.timeBoard.transform:Find("Show/Tex_Oclock"):GetComponent(typeof(CS.ExText));
		texttip.text = string.gsub(texttip.text, "\\n", "\n");
		local textshow = self.timeBoard.transform:Find("Show/Tex_TimeZone"):GetComponent(typeof(CS.ExText));
		textshow.text = string.gsub(textshow.text, "\\n", "\n");
		--local trans = self.timeBoard:GetComponent(typeof(CS.UnityEngine.RectTransform));
		--trans.sizeDelta = CS.UnityEngine.Vector2(trans.sizeDelta.x,CS.OPSPanelBackGround.Instance.mapSize.y*10);
	end
end
util.hotfix_ex(CS.OPSRuler,'InitUnclockTime',OPSRuler_InitUnclockTime)