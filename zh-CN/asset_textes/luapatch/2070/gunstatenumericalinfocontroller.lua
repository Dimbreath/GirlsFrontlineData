local util = require 'xlua.util'
xlua.private_accessible(CS.GunStateNumericalInfoController)
local _MarryPerformance = function(self)
	if CS.UISimulatorFormation.Instance==nil then
		pcall(function() self:MarryPerformance() end);
	else
		self:MarryPerformance();
	end
end
local _MarryRecall = function(self)
	if CS.UISimulatorFormation.Instance==nil then
		pcall(function() self:MarryRecall() end);
	else
		self:MarryRecall();
	end
end
util.hotfix_ex(CS.GunStateNumericalInfoController,'MarryPerformance',_MarryPerformance)
util.hotfix_ex(CS.GunStateNumericalInfoController,'MarryRecall',_MarryRecall)