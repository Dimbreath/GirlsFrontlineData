local util = require 'xlua.util'
xlua.private_accessible(CS.DormAI)
local Init = function(self)
    self:Init();
    if self.aiInfo ~= nil then
        for i=0,self.aiInfo.length-1 do
            if self.aiInfo.actions[i] ~= nil and self.aiInfo.actions[i].interactType > 0 then
                self.aiInfo.actions[i].jumpInAction = true;
                print(i);
            end
        end
    end
end
util.hotfix_ex(CS.DormAI,'Init',Init)