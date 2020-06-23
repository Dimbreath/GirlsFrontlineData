local util = require 'xlua.util'
xlua.private_accessible(CS.AVGShowLogController)
local ShowContent = function(self,data,isLast)
    local go = self:InstantiateOneLine();
    self:GetNameText(go).text = data.dialogueName;
    self:GetContentText(go).text = string.gsub(self:Content(data, isLast),"//n","\n");
    if data.listBranchContent ~= null and data.listBranchContent.Count > 0 and data.selectNum > 0 then
        local branch = self:InstantiateOneLine();
        self:GetNameText(branch).text = "";--CS.Data.GetLang("TODO【选项】");
        self:GetContentText(branch).text = self:BranchContent(data);
        branch = nil;
    end
    go = nil;
end
xlua.hotfix(CS.AVGShowLogController,'ShowContent',ShowContent)