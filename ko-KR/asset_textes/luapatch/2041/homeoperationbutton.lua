local util = require 'xlua.util'
xlua.private_accessible(CS.HomeOperationButton)
local ChangeButtonImage = function(self)
	if self.statement == CS.HomeOperationState.ResumeBattle then
		if self.info.campaign < 0 then
			local flag = false
			for i = 0,CS.MissionSelectionActivityController.MissionConfigs.Count-1 do
				if CS.MissionSelectionActivityController.MissionConfigs[i].campaignId == self.info.campaign then
					flag = true
					break
				end		
			end
			if flag == false then
				self.imageBackMission.sprite = CS.CommonController.LoadPngCreateSprite("Pics/Icons/OPS/" .. CS.OPSConfig.Instance.MissionSelectionTex .. "_base")
				return
			end
		end
	end
	self:ChangeButtonImage()
end
local OnClick = function(self)

	self:OnClick()
	if self.statement == CS.HomeOperationState.ShowTheater then
		CS.CommonController.GotoScene("Theater")
	end
end
util.hotfix_ex(CS.HomeOperationButton,'ChangeButtonImage',ChangeButtonImage)
util.hotfix_ex(CS.HomeOperationButton,'OnClick',OnClick)