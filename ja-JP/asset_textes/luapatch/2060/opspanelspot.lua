local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelSpot)
xlua.private_accessible(CS.OPSPanelController)

local Show = function(self,play,delay)
	if play and self.mission ~= nil and CS.OPSPanelController.difficulty ~= self.difficulty then
		--CS.OPSPanelController.Instance:SelectDiffcluty();
		CS.OPSPanelController.difficulty = self.difficulty;
		CS.OPSPanelController.diffclutyRecord = self.difficulty;
		for i=0,CS.OPSPanelController.diffcluteNum-1 do			
			local child = CS.OPSPanelController.Instance.btnTitle.transform:Find(tostring(i));
			if child ~= nil then
				child.gameObject:SetActive(i == CS.OPSPanelController.difficulty);
			end
		end
		CS.OPSPanelController.Instance:RefreshUI();
		if CS.OPSPanelController.Instance.background3d ~= nil then
			local pos = CS.OPSPanelBackGround.Instance.modelPos+CS.UnityEngine.Vector3(0,0,-550*CS.OPSPanelController.difficulty);
			CS.OPSPanelController.Instance.background3d.transform:DOLocalMove(pos,0.5);
		end
		delay = delay + 0.5;
		--local btn = CS.OPSPanelController.Instance.btnTitle;
		--if btn ~= nil then
			--local pos = CS.UnityEngine.Vector3(btn.transform.position.x,btn.transform.position.y,btn.transform.position.z);
		--	self.transform:DOMove(btn.transform.position,1):SetDelay(1);
		--	self.transform:DOScale(CS.UnityEngine.Vector3.zero,0.5):SetDelay(1.5);
		--	self.path.BezierRenderer.material:DOFloat(0,"_Alpha",0.5):SetDelay(1);
		--end
	end
	--print(self.missionId);
	if play then
		self:Hide();
	end
	self:Show(play,delay);
end

util.hotfix_ex(CS.OPSPanelSpot,'Show',Show)

