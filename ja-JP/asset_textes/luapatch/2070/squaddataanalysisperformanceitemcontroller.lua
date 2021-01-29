local util = require 'xlua.util'
xlua.private_accessible(CS.SquadDataAnalysisPerformanceItemController)

local Init = function(self,price)
	self:Init(price);
	if price.isGeneralPiece then
		local textName = self.uiHolder:GetUIElement("InfoNode/UI_Text_ItemName",typeof(CS.ExText));
		if textName ~= nil then
			textName.text = CS.GameData.listItemInfo:GetDataById(price.id).name;
		end
		textName = nil;
	end
end

util.hotfix_ex(CS.SquadDataAnalysisPerformanceItemController,'Init',Init)
