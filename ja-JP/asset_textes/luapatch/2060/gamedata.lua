local util = require 'xlua.util'

local GetItem_New = function(item)
	if type(item) ~= "number" and item ~= nil and item.itemId ~= nil then		
		return CS.GameData.GetItem(item.itemId)
	else 
		return CS.GameData.GetItem(item)
	end
end

local skillBelong_New = function(self)
	if self.belong == CS.Belong.neutral then
		return 3;
	elseif self.belong == CS.Belong.friendly then
		return 1;
	elseif self.belong == CS.Belong.enemy then
		return 2;
	elseif self.belong == CS.Belong.hide then
		return 99;
	elseif self.belong == CS.Belong.ingore then
		return 100;
	else
		return 0;
	end
end

util.hotfix_ex(CS.GameData,'GetItem',GetItem_New)
util.hotfix_ex(CS.SpotAction,'get_skillBelong',skillBelong_New)
