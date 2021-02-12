local util = require 'xlua.util'
xlua.private_accessible(CS.HomeOperationButton)

local ChangeButtonImage = function(self)
	self:ChangeButtonImage();
	if self.statement == CS.HomeOperationState.ResumeBattle then
		if CS.GameData.missionAction.missionInfo.missionType == CS.MissionType.Activity then
			local obj = CS.ResManager.GetObjectByPath("Pics/Icons/OPS/"..CS.OPSConfig.Instance.MissionSelectionTex.."_base2",".png");
			if obj ~= nil then
				self.imageBackEvent.sprite = CS.CommonController.LoadPngCreateSprite("Pics/Icons/OPS/"..CS.OPSConfig.Instance.MissionSelectionTex.."_base2");
				self.imageBackEventHL.sprite = self.imageBackEvent.sprite;
			end
		end
	end
end

util.hotfix_ex(CS.HomeOperationButton,'ChangeButtonImage',ChangeButtonImage)