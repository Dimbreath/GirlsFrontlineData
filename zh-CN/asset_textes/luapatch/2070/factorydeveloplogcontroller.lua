local util = require 'xlua.util'
xlua.private_accessible(CS.FactoryDevelopLogController)

local RefreshPrecisionEquipProduceInfo = function(self)
	self:RefreshPrecisionEquipProduceInfo();
	if self.gobjSpBuildNode.activeSelf then
		local imageIcon = self.uiHolder:GetUIElement("Img_SpTopBanner/SpBuildNode/Img_SpBuildTickets", typeof(CS.UnityEngine.UI.Image))
		CS.CommonController.LoadImageIcon(imageIcon, "Pics/Icons/Item/Special_Equip_Ticket");
	end
end

util.hotfix_ex(CS.FactoryDevelopLogController,'RefreshPrecisionEquipProduceInfo',RefreshPrecisionEquipProduceInfo)


