local util = require 'xlua.util'
xlua.private_accessible(CS.CommonLive2DController)

local SetScenePos_New = function(self)
	local selfPath = CS.Data.GetLive2DPath(self.transform)
	--CS.NDebug.LogError("SetScenePos_New"..selfPath)

	if selfPath == "WeddingPlay(Clone)" then
		for i=0,self.currModel.live2dPosDataList.Count-1 do
			if self.currModel.live2dPosDataList[i].sceneName == "Home" and self.currModel.live2dPosDataList[i].path == "Live2DCanvas/btnPicHolder" then
				self.transform:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = CS.UnityEngine.Vector2(self.currModel.live2dPosDataList[i].anchoredPos.x,self.currModel.live2dPosDataList[i].anchoredPos.y)
				self.currModel.transform.localScale = self.currModel.live2dPosDataList[i].scale
				return
			end
		end		
	else
		self:SetScenePos()
	end	
end

util.hotfix_ex(CS.CommonLive2DController,'SetScenePos',SetScenePos_New)


