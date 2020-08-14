local util = require 'xlua.util'

local GetItem_New = function(item)
	if type(item) ~= "number" and item ~= nil and item.itemId ~= nil then		
		return CS.GameData.GetItem(item.itemId)
	else 
		return CS.GameData.GetItem(item)
	end
end


util.hotfix_ex(CS.GameData,'GetItem',GetItem_New)
