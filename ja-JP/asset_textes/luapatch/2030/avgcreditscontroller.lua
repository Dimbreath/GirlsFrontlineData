local util = require 'xlua.util'
xlua.private_accessible(CS.AVGCreditsController)
xlua.private_accessible(CS.IllustratedBookPlayAVGButtonController)
xlua.private_accessible(CS.IllustratedBookCGPlayBackController)
xlua.private_accessible(CS.RequestCredits)
local Start = function(self)
    CS.AVGLanguageManager.Instance:LoadAVGLanguageData();
    local txt = nil
    if CS.IllustratedBookCGPlayBackController.Instance == nil then
        txt = CS.AVGLanguageManager.Instance:FromIdToText(CS.GameData.currentSelectedMissionInfo.id)
    else
        txt = CS.AVGLanguageManager.Instance:FromIdToText(CS.IllustratedBookCGPlayBackController._currentSelectedCampaignId)
    end
    txt = string.gsub(txt, '//n', '\r\n')
    self.exText.text = txt
    local rectTrans = self.exText:GetComponent(typeof(CS.UnityEngine.RectTransform))
    rectTrans.sizeDelta = CS.UnityEngine.Vector2(rectTrans.sizeDelta.x, self.exText.preferredHeight + (self.rectTransform.rect.height / 2.0) - self.exText.fontSize)
    self.scrollRect.verticalNormalizedPosition = 1
    self:StartCoroutine(self:PlayCreditsController())
    txt = nil
    rectTrans = nil
end
local OnClick = function(self)
    self:OnClick()
    if self.info ~= nil and self.info.mission ~= nil then
        CS.IllustratedBookCGPlayBackController._currentSelectedCampaignId = self.info.mission.missionInfo.id
    end
end
local Request = function(self)
    self.writer:WriteObjectStart()
    self.writer:WritePropertyName("mission_id")
    if CS.IllustratedBookCGPlayBackController.Instance == nil then
        self.writer:Write(CS.GameData.currentSelectedMissionInfo.id)
    else
        self.writer:Write(CS.IllustratedBookCGPlayBackController._currentSelectedCampaignId)
    end
    self.writer:WriteObjectEnd()
    self:Request()
end
xlua.hotfix(CS.AVGCreditsController,'Start',Start)
util.hotfix_ex(CS.IllustratedBookPlayAVGButtonController,'OnClick',OnClick)
util.hotfix_ex(CS.RequestCredits,'Request',Request)