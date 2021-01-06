local util = require 'xlua.util'
xlua.private_accessible(CS.CutinController)
xlua.private_accessible(CS.BattleUILifeBarController)

local UpdateScene = function(self)
    self:UpdateScene()
	print(self.currentSequenceId)
	print(self.arrFriendlyCutin.Length)
	print(self.arrEnemyCutin.Length)
	if self.splitCount == 2 then
		if self.currentSequenceId <= self.arrFriendlyCutin.Length then
			self.arrImage[1].transform.localScale =CS.UnityEngine.Vector3(1, 1, 1)
            self.arrImage[1].material:SetFloat("_Size", 0.64)
            self.arrImage[1].material:SetTextureOffset("_AlphaTex", CS.UnityEngine.Vector2(0, 0))
            self.arrImage[1].material:SetTextureScale("_AlphaTex", CS.UnityEngine.Vector2(1.48, 1))
		else
			self.arrImage[1].transform.localScale =CS.UnityEngine.Vector3(-1, 1, 1)
            self.arrImage[1].material:SetFloat("_Size", -0.45)
            self.arrImage[1].material:SetTextureOffset("_AlphaTex", CS.UnityEngine.Vector2(-0.5, 0))
            self.arrImage[1].material:SetTextureScale("_AlphaTex", CS.UnityEngine.Vector2(1.48, 1))
		end
	end
	if self.splitCount == 3 then
		if self.currentSequenceId <= self.arrFriendlyCutin.Length then
			self.arrImage[1].material:SetTextureOffset("_AlphaTex", CS.UnityEngine.Vector2(0, 0))
			self.arrImage[1].transform.localScale =CS.UnityEngine.Vector3(1, 1, 1)
			self.arrImage[2].transform.localScale =CS.UnityEngine.Vector3(1, 1, 1)
		else
			self.arrImage[1].material:SetTextureOffset("_AlphaTex", CS.UnityEngine.Vector2(0, 0))
			self.arrImage[1].transform.localScale =CS.UnityEngine.Vector3(-1, 1, 1)
			self.arrImage[2].transform.localScale =CS.UnityEngine.Vector3(-1, 1, 1)
		end
	end
	
end
local InitUIElements = function(self)
	self:InitUIElements();
	xlua.hotfix(CS.BattleUILifeBarController,'Init',nil)
end
util.hotfix_ex(CS.CutinController,'InitUIElements',InitUIElements)
util.hotfix_ex(CS.CutinController,'UpdateScene',UpdateScene)