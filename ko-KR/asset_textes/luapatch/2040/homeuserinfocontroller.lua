local util = require 'xlua.util'
xlua.private_accessible(CS.HomeUserInfoController)
xlua.private_accessible(CS.Extensions)
xlua.private_accessible(CS.AdjutantListController)

local OnPointerClick = function(self,e)
    CS.Extensions.cachedSidebarShowCount = 1
    self:OnPointerClick(e)
end
util.hotfix_ex(CS.HomeUserInfoController, 'OnPointerClick', OnPointerClick)

local OnClickAdjustant = function(self)
    self:OnClickAdjustant();
    self.commanderSpineHolder.gameObject:SetActive(false);
end
util.hotfix_ex(CS.HomeUserInfoController, 'OnClickAdjustant', OnClickAdjustant)

local Close = function(self)
    self:Close();
    CS.HomeUserInfoController.Instance:ShowSpine();
end
util.hotfix_ex(CS.AdjutantListController, 'Close', Close)