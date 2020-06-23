local util = require 'xlua.util'
xlua.private_accessible(CS.CommonPicLoader)

local CommonPicLoader_StartLoad = function(self)
	if CS.ResCenter.NORMAL == true then
		local check = {}
		for i=0, self.pathsToLoad.Count -1 do
			--print(string.find(self.pathsToLoad[i],"_HE"))
			if string.find(self.pathsToLoad[i],"_HE") ~=nil then
				table.insert(check,self.pathsToLoad[i])
			end
		end
		for i=1,#(check) do
			self.pathsToLoad:Remove(check[i]);
		end
	end
	self:StartLoad();
end
util.hotfix_ex(CS.CommonPicLoader,'StartLoad',CommonPicLoader_StartLoad)