local util = require 'xlua.util'
xlua.private_accessible(CS.Package)
local Package_FormatJsonData = function(self,jsonData,...)
	local length = select('#', ...);
	if length > 1 then
		return self:FormatJsonData(jsonData,...);
	else
		local names = select(1, ...);
		if names == "commander_uniform" then
        	local arry=jsonData:GetValue("commander_uniform");
        	if arry.IsArray then
            	for i=0,arry.Count-1 do 
                	if arry[i].IsInt then
                     	self.listUniform:Add(arry[i].Int);
                	else
                    	local id = arry[i]:GetValue("commander_uniform_id").Int;
                    	self.listUniform:Add(id);
                	end
            	end
            	arry = nil;
            	return nil;
        	else
            	return self:FormatJsonData(jsonData,names);
        	end
    	else
        	return self:FormatJsonData(jsonData,names);
    	end
	end 
end
local Package_GetPackage = function(self,...)
	local furnitureNotInit = false;
	if CS.GameData.listFurniture == nil then
		furnitureNotInit = true;
		CS.GameData.listFurniture = CS.tBaseDatas(CS.Furniture)();
	end
	self:GetPackage(...);
	if furnitureNotInit then
		CS.GameData.listFurniture = nil;
	end
	furnitureNotInit = nil;
end
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
util.hotfix_ex(CS.Package,'FormatJsonData',Package_FormatJsonData)
util.hotfix_ex(CS.Package,'GetPackage',Package_GetPackage)