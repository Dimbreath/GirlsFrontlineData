local util = require 'xlua.util'
xlua.private_accessible(CS.NavigationItemStationController)
local myInitReferenceRoom = function(self)
   if(CS.NavigationController.needGetData:Contains(CS.NavigationControllerEnumType.referenceRoom_NC)) then
            local esDesk = CS.Data.GetEstablishWithType(CS.EstablishType.DataRoomMain_201);
			print("dasda")
            if (esDesk ~= nil  and esDesk.isProducing == true) then
                self.texTime.gameObject:SetActive(true);
                self.texTime.text = CS.GameData.FormatLongToTimeStr(esDesk.produceEndTime - CS.GameData.GetCurrentTimeStamp());
            else
                self.texTime.gameObject:SetActive(false);
            end
	end
end
util.hotfix_ex(CS.NavigationItemStationController,'InitReferenceRoom',myInitReferenceRoom)