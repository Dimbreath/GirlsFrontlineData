local util = require 'xlua.util'
xlua.private_accessible(CS.FactoryController)
local get_goRetire = function(self)
	local goRetire1 ;
	if self.factoryUIObjectDict:ContainsKey(CS.FactoryUIType.Retire) == false then
		goRetire1 = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("UGUIPrefabs/FactoryPrefabs/RetireMain"), self.mainPos);
		self.factoryUIObjectDict:Add(CS.FactoryUIType.Retire,goRetire1);
	end
	goRetire1 = self.factoryUIObjectDict[CS.FactoryUIType.Retire];
	return goRetire1;
end
util.hotfix_ex(CS.FactoryController,'get_goRetire',get_goRetire)