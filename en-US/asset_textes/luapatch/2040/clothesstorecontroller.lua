local util = require 'xlua.util'
xlua.private_accessible(CS.ClothesStoreController)
xlua.private_accessible(CS.DressUpChangeClothesItemController)

local myOnClickDressUpChangeItem = function(self)
    self:OnClickDressUpChangeItem()
    local i = self.obj:IndexOf(self.selectedItem:GetComponent('DressUpChangeClothesItemController'))
    local good = self.readyBuyGoods:ContainsKey(CS.UniformType.__CastFrom(i + 1)) and self.readyBuyGoods[CS.UniformType.__CastFrom(i + 1)] or nil;
    if(good ~= nil) then
        self.lastSelectedUniformInfo = self.selectedItem:GetComponent("DressUpChangeClothesItemController").info;
        local isMoreColor = self.lastSelectedUniformInfo:CheckColorMatch();
        self.btn_ChooseColor.gameObject:SetActive(isMoreColor);
        self.chooseColorGride.gameObject:SetActive(true);
        self:OnClickShowColorGride();
    else
        self.btn_ChooseColor.gameObject:SetActive(false);
        self.chooseColorGride.gameObject:SetActive(false);
    end
end
local myChangeView = function(self, info)
    self:ChangeView(info);
    self.info = info;

end
util.hotfix_ex(CS.ClothesStoreController,'OnClickDressUpChangeItem',myOnClickDressUpChangeItem)
util.hotfix_ex(CS.DressUpChangeClothesItemController,'ChangeView',myChangeView)