local util = require 'xlua.util'
xlua.private_accessible(CS.AVGCreditsController)

local DestroyCredits = function(self)
	CS.AVGController.Instance.isOnClickDestroy = false;
	self:StopAllCoroutines();
	CS.AVGController.Instance:CanPlayNextNode(true);
	CS.UnityEngine.Object.Destroy(self.gameObject);
end

xlua.hotfix(CS.AVGCreditsController,'DestroyCredits',DestroyCredits)