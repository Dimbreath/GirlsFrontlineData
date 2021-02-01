local util = require 'xlua.util'
xlua.private_accessible(CS.SummonGun)
local Init = function(self,parent)
	self:Init(parent);
	self.crit = self:GetAttrFromFormula(self.summonInfo.crit_hit, parent);
	self.criHarmRate = self:GetAttrFromFormula(self.summonInfo.angle, parent); 
	return self;
end

util.hotfix_ex(CS.SummonGun,'Init',Init)