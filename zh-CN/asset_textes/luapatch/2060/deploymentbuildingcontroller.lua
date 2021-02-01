local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingController)

local CheckUseBattleSkill = function(self)
	if CS.DeploymentBackgroundController.Instance.listSpotPath.Count ~= 0 then
		self:CheckUseBattleSkill();
	end
end

local CheckDefender = function(self,playcameramove,time)
	if not self.gameObject.activeInHierarchy then
		self.lastactiveid = self.buildAction.activeOrder;
	end
	self:CheckDefender(playcameramove,time);
end

local Update = function(self)
	if self.skeletonAnimation ~= nil and not self.skeletonAnimation:isNull() then
		if self.show ~= self.spot.Show then
			if self.spot.Show then
				self.Mat:DOFloat(1,"_Alpha",0.5);
			else
				self.Mat:DOFloat(0,"_Alpha",0.5);
			end
		end	
		self.show = self.spot.Show;
	end
	self:Update();
end

local Init = function(self)
	self.show = false;
	self:Init();
	self:CheckMatShader();
end

util.hotfix_ex(CS.DeploymentBuildingController,'CheckUseBattleSkill',CheckUseBattleSkill)
util.hotfix_ex(CS.DeploymentBuildingController,'CheckDefender',CheckDefender)
util.hotfix_ex(CS.DeploymentBuildingController,'Update',Update)
util.hotfix_ex(CS.DeploymentBuildingController,'Init',Init)