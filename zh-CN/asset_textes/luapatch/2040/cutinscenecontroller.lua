local util = require 'xlua.util'
xlua.private_accessible(CS.CutinSceneController)
local gunTable = {"GustafCut1","GustafCut2","GustafCut3","GustafAssist1"}
local OffsetDataTableX = {-2,0.5,0,1.6}
local OffsetDataTableY = {1.3,-0.2,0,1.3}
local ScaleTableX = {0.55,1,1,0.5}
local ScaleTableY = {0.55,1,1,0.5}
local CreatePerformanceSquad = function(self,summonerData,offsetIndex)
    self:CreatePerformanceSquad(summonerData,offsetIndex)
	for i=1,#gunTable do
		if self.character.gun:GetCode() == gunTable[i] then
			self.character.transform.localPosition = CS.UnityEngine.Vector3(OffsetDataTableX[i],OffsetDataTableY[i],0)
			self.character.transform.localScale = CS.UnityEngine.Vector3(ScaleTableX[i],ScaleTableY[i],1)
			break
		end
	end
end

util.hotfix_ex(CS.CutinSceneController,'CreatePerformanceSquad',CreatePerformanceSquad)