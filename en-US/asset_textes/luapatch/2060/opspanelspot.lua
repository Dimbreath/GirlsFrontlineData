local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelSpot)
xlua.private_accessible(CS.OPSPanelController)

local Show = function(self,play,delay)
	self:Show(play,delay);
	if play and self.mission ~= nil and CS.OPSPanelController.difficulty ~= self.difficulty then
		CS.OPSPanelController.difficulty = self.difficulty;
		CS.OPSPanelController.Instance:RefreshUI();
		--local btn = CS.OPSPanelController.Instance.btnTitle;
		--if btn ~= nil then
			--local pos = CS.UnityEngine.Vector3(btn.transform.position.x,btn.transform.position.y,btn.transform.position.z);
		--	self.transform:DOMove(btn.transform.position,1):SetDelay(1);
		--	self.transform:DOScale(CS.UnityEngine.Vector3.zero,0.5):SetDelay(1.5);
		--	self.path.BezierRenderer.material:DOFloat(0,"_Alpha",0.5):SetDelay(1);
		--end
	end
end

util.hotfix_ex(CS.OPSPanelSpot,'Show',Show)

