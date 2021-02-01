local util = require 'xlua.util'
xlua.private_accessible(CS.FormationSimulatorCharacterLabelController)
local OnBeginDrag = function(self,...)
	if CS.UISimulatorFormation.Instance.isFormationLabelChanging == CS.OnDragState.NoneDrag then
		CS.UISimulatorFormation.Instance.gameObject.transform:Find("Formation/Main/Labels").gameObject:GetComponent(typeof(CS.UnityEngine.UI.GridLayoutGroup)).enabled = false
	end
	self:OnBeginDrag(...)

end
util.hotfix_ex(CS.FormationSimulatorCharacterLabelController,'OnBeginDrag',OnBeginDrag)
