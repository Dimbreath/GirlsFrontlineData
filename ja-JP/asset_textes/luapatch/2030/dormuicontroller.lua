local util = require 'xlua.util'
xlua.private_accessible(CS.DormUIController)
local ReturnEdit = function()
    if CS.DormUIController.Instance ~= nil then
        CS.DormUIController.Instance:ReturnEdit()
    end
end
local HideAllUI = function()
    if CS.DormUIController.Instance ~= nil then
        CS.DormUIController.Instance:HideAllUI()
    end
end
local OnPanelActivated = function(self,name)
    if name == 'SpareRoom' then
        self.uiHolder:GetUIElement("SpareRoom/Edit",typeof(CS.UnityEngine.UI.Button)):AddOnClick(ReturnEdit, CS.AudioUI.NONE)
        self.uiHolder:GetUIElement("SpareRoom/Show",typeof(CS.UnityEngine.UI.Button)):AddOnClick(HideAllUI, CS.AudioUI.NONE)
    end
    self:OnPanelActivated(name)
end
util.hotfix_ex(CS.DormUIController,'OnPanelActivated',OnPanelActivated)