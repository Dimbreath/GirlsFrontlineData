local util = require 'xlua.util'
xlua.private_accessible(CS.GashaponController)

local GashaponController_InitGashaponView = function(self)
	self:StartDateTimeDown();
	self:RefreshTopCoinNumber();
	self:InitTopTitleTable();
	
	self.currentIndex = 0;
    self.startIdx = 0;
    self.gashaTypeIdx = -1;
    self.selectTab = 0;
	if self.nameTabBtnTransList ~= nil and self.nameTabBtnTransList.Count>0 then
		self:RefreshGashaponView(self.nameTabBtnTransList.Count-1);
	end 
end
util.hotfix_ex(CS.GashaponController,'InitGashaponView',GashaponController_InitGashaponView)