local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSquadTeamController)
xlua.private_accessible(CS.MissionControllerInfo)
local lineColor = CS.UnityEngine.Color.white;
local DeploymentSquadTeamController_CheckSpecialSpotLine = function(self)
	 if self.currentSpot.spotAction ~= null then
	 	for i=0,self.currentSpot.spotAction.battleSquadTeam.Count -1 do
	 		local skillsquadTeam = self.currentSpot.spotAction.battleSquadTeam[i];
	 		if skillsquadTeam ~= self.squadTeam and skillsquadTeam.asSkillBelong == self.squadTeam.currentBelong then
	 			if not self.squatLine:ContainsKey(skillsquadTeam) then
	 				local line = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("UGUIPrefabs/Deployment/DeploymentPath")):GetComponent(typeof(CS.DeploymentLine));
	 				line.transform:SetParent(self.transform.parent, false);
	 				if skillsquadTeam.currentBelong == CS.TeamBelong.friendly then
	 					lineColor = CS.DeploymentController.Instance.playerMissionControllerInfo.playerLineColor;
	 				elseif  skillsquadTeam.currentBelong == CS.TeamBelong.enemy then
	 					lineColor =  CS.DeploymentController.Instance.enemyMissionControllerInfo.spotColor;
	 				else
	 					lineColor =  CS.DeploymentController.Instance.thirdMissionControllerInfo.otherLineColor;
	 				end
	 				if skillsquadTeam.squadTeamController ~= nil then	              
                    	line.fromTeam = skillsquadTeam.squadTeamController;
                    	line.localStartOffset = CS.UnityEngine.Vector3(0,0.6,0);
                    	line.localEndOffset = CS.UnityEngine.Vector3(0, 0.6, 0);
                    	line:ShowCurve(skillsquadTeam.squadTeamController.spineHolder, self.spineHolder, lineColor);               
                	elseif skillsquadTeam.allyTeam  ~= nil then            
	                    line.fromTeam = skillsquadTeam.allyTeam.allyTeamController;
	                    line.localStartOffset = CS.UnityEngine.Vector3(0, 0.6, 0);
	                    line.localEndOffset = CS.UnityEngine.Vector3(0, 0.6, 0);
	                    line:ShowCurve(skillsquadTeam.allyTeam.allyTeamController.spineHolder, self.spineHolder, lineColor);
                	end
                	self.squatLine:Add(skillsquadTeam, line);
	 			end
	 		end
	 	end
	 end
	 self:CheckSpecialSpotLine();
end

util.hotfix_ex(CS.DeploymentSquadTeamController,'CheckSpecialSpotLine',DeploymentSquadTeamController_CheckSpecialSpotLine)