local util = require 'xlua.util'
xlua.private_accessible(CS.Package)
local Package_CheckJsonValid = function(self,jsonData,...)
    local length = select('#', ...);
     
    if length == 5 then
        local name1 = select(1, ...);
        local name2 = select(2, ...);
        local name3 = select(3, ...);
        local name4 = select(4, ...);
        local name5 = select(5, ...);
        return self:CheckJsonValid(jsonData,name1,name2,name3,name4,name5,"commander_uniform");
    else
        return self:CheckJsonValid(jsonData,...);
    end 
end
util.hotfix_ex(CS.Package,'CheckJsonValid',Package_CheckJsonValid)