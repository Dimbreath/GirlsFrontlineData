local util = require 'xlua.util'
xlua.private_accessible(CS.GunStateNumericalInfoController)
local _MarryPerformance = function(self)
	self:MarryPerformance();
	if CS.UISimulatorFormation.Instance~=nil and CS.UISimulatorFormation.Instance.gameObject ~=nil then
		CS.UISimulatorFormation.Instance.gameObject:SetActive(false);
	end
end
local _MarryRecall = function(self)
	self:MarryRecall();
	if CS.UISimulatorFormation.Instance~=nil and CS.UISimulatorFormation.Instance.gameObject ~=nil then
		CS.UISimulatorFormation.Instance.gameObject:SetActive(false);
	end
end
util.hotfix_ex(CS.GunStateNumericalInfoController,'MarryPerformance',_MarryPerformance)
util.hotfix_ex(CS.GunStateNumericalInfoController,'MarryRecall',_MarryRecall)