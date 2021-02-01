local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamInfoController)

local DeploymentTeamInfoController_CheckNeedAndCanSupply = function(teamid,showMessage)
	if teamid>0 then
		return CS.DeploymentTeamInfoController.CheckNeedAndCanSupply(teamid,showMessage);
	else
		return  false;
	end
end

local DeploymentTeamInfoController_RequestSangvisTeamReinforceHandle = function(self,data)
	CS.GameData.userInfo.mp = CS.GameData.userInfo.mp - self.costMp;
	self:RequestSangvisTeamReinforceHandle(data);
end

local DeploymentTeamInfoController_ShowCurrentTeamNum = function(self,issangvisTeam)
	self:ShowCurrentTeamNum(issangvisTeam);
	self.deployNumTip:GetComponent(typeof(CS.ExImage)).raycastTarget = false;
	self.deployNumTip:Find("Img_Bg"):GetComponent(typeof(CS.ExImage)).raycastTarget = false;
	self.deployNumTip:Find("Img_NumBg"):GetComponent(typeof(CS.ExImage)).raycastTarget = false;
	self.deployNumTip:Find("Tex_Echolon"):GetComponent(typeof(CS.ExText)).raycastTarget = false;
	self.deployNumTip:Find("Tex_Num"):GetComponent(typeof(CS.ExText)).raycastTarget = false;
end

local DeploymentTeamInfoController_OnClickButton = function(self,button)
	if button == "Deploy" then
		local teamid = CS.DeploymentTeamInfoController.currentSelectedTeamId;
		if teamid > 0 then
			local leader = CS.GameData.dictTeam[teamid]:GetLeader(false);
			if leader == nil then
				local txt = CS.Data.GetLang(20041);
				local txt1 = CS.Data.GetLang((CS.LanguageConfig.ELANS_TYPE_NUM.__CastFrom(teamid)));
				CS.CommonController.LightMessageTips(CS.System.String.Format(txt,txt1));
				return;
			end
			if CS.GameData.dictTeam[teamid].CostRes ~= nil then
				local totalCost = CS.Data.GetSangvisTeamBasicCost();
				local cost = 0;
				local currentTeam = CS.GameData.dictTeam[teamid];
				local gun = nil;
				for t = 0, 8 do
					if (currentTeam.dictLocation:ContainsKey(t + 1) and currentTeam.dictLocation[t + 1] ~= nil) then
						gun = currentTeam.dictLocation[t + 1];
						totalCost = totalCost + gun.sangvisInfo:GetAddCost(t+1);
						cost = cost + gun.sangvisInfo.ap_cost;
					end
				end
				if cost > totalCost then
					local txt = CS.Data.GetLang(30406);
					local txt1 = CS.Data.GetLang(teamid);
					CS.CommonController.LightMessageTips(CS.System.String.Format(txt,txt1));
					return;
				end
			end
		end		
	end
	self:OnClickButton(button);
end

util.hotfix_ex(CS.DeploymentTeamInfoController,'CheckNeedAndCanSupply',DeploymentTeamInfoController_CheckNeedAndCanSupply)
util.hotfix_ex(CS.DeploymentTeamInfoController,'RequestSangvisTeamReinforceHandle',DeploymentTeamInfoController_RequestSangvisTeamReinforceHandle)
util.hotfix_ex(CS.DeploymentTeamInfoController,'ShowCurrentTeamNum',DeploymentTeamInfoController_ShowCurrentTeamNum)
util.hotfix_ex(CS.DeploymentTeamInfoController,'OnClickButton',DeploymentTeamInfoController_OnClickButton)