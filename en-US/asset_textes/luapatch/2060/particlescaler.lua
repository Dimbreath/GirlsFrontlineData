local util = require 'xlua.util'
xlua.private_accessible(CS.ParticleScaler)

local DeploymentInit = function(self)
	self.useInDeployment = CS.UnityEngine.Application.loadedLevelName == "Deployment";
	if self.useInDeployment then
		self.transform.localPosition = CS.UnityEngine.Vector3.zero;
	else
		return;
	end
	if not CS.UnityEngine.Camera.main.orthographic then 
		self.setSize = self.setSize*0.5;
	end
	if self.delayTime == 0 then
		print("激活子对象"..self.gameObject.name);
		for i=0,self.transform.childCount-1 do
			self.transform:GetChild(i).gameObject:SetActive(true);
		end
	else
		for i=0,self.transform.childCount-1 do
			self.transform:GetChild(i).gameObject:SetActive(false);
		end	
		print("当前延时"..self.delayTime..self.gameObject.name);
	end
end

local SetMoveValue = function(self,start,sCol,end1,eCol)
	sCol = start + CS.UnityEngine.Vector2(0,100);
	eCol = end1 + CS.UnityEngine.Vector2(0,100);
	self:SetMoveValue(start,sCol,end1,eCol);
	self.transform.localPosition = CS.UnityEngine.Vector3(start.x,start.y,0);
end
util.hotfix_ex(CS.ParticleScaler,'DeploymentInit',DeploymentInit)
util.hotfix_ex(CS.ParticleScaler,'SetMoveValue',SetMoveValue)

