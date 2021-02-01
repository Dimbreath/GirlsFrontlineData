local util = require 'xlua.util'
xlua.private_accessible(CS.HomeMotherBaseScrollController)
local RefreshList = function(self)
	
	for i=0,self.ItemConfigList.Count-1 do
		if self.ItemConfigList[i].type == CS.MotherBaseScrollItemType.InfoCenter then
			local tt = self.ItemConfigList[i]
			local ts = CS.ScrollItemInfo()
			ts.type = CS.MotherBaseScrollItemType.InfoCenter
			ts.priority = tt.priority
			ts.itemSprite = tt.itemSprite
			ts.strItemName = tt.strItemName			
			ts.show = CS.Data.GetEstablishRoomUnlocked(CS.EstablishRoom.SquadBase)
			self.ItemConfigList[i] = ts
		end
		if self.ItemConfigList[i].type == CS.MotherBaseScrollItemType.expedition then
			local tt = self.ItemConfigList[i]
			local ts = CS.ScrollItemInfo()
			ts.type = CS.MotherBaseScrollItemType.expedition
			ts.priority = tt.priority
			ts.itemSprite = tt.itemSprite
			ts.strItemName = tt.strItemName	
			ts.show = CS.Data.GetEstablishRoomUnlocked(CS.EstablishRoom.ExploreRoom)
			self.ItemConfigList[i] = ts
		end
	end
	self:RefreshList()
	
end

util.hotfix_ex(CS.HomeMotherBaseScrollController,'RefreshList',RefreshList)