local util = require 'xlua.util'
xlua.private_accessible(CS.BatchDevelopConfirmBoxController)

local InitUIElements = function(self)
	self:InitUIElements();
	self.uiHolder:GetUIElement("background/SpEquipmentHolder/TicketNode/Img_SpEquipHolder",typeof(CS.ExImage)).color = CS.UnityEngine.Color(0,0,0,0);
	self.uiHolder:GetUIElement("background/SpEquipmentHolder/DoubleNode/Img_SpEquipHolder",typeof(CS.ExImage)).color = CS.UnityEngine.Color(0,0,0,0);
	CS.CommonController.LoadImageIcon(self.uiHolder:GetUIElement("background/SpEquipmentHolder/TicketNode/Img_SpEquipHolder/Img_SpEquipTicket",typeof(CS.ExImage)), "Pics/Icons/Item/Special_Equip_Ticket");
	CS.CommonController.LoadImageIcon(self.uiHolder:GetUIElement("background/SpEquipmentHolder/DoubleNode/Img_SpEquipHolder/Img_SpEquipTicket",typeof(CS.ExImage)), "Pics/Icons/Item/Special_Equip_Ticket");
end

util.hotfix_ex(CS.BatchDevelopConfirmBoxController,'InitUIElements',InitUIElements)


