local util = require 'xlua.util'
xlua.private_accessible(CS.CommonVideoPlayer)
local OnClickUIBG = function(self)
	if (string.find(self.videoPath,"M4OGAScutin"))~=nil then
		return
	end
	self.OnClickUIBG()
end
local OnClickBG = function(self)
	print(CS.CommonVideoPlayer.videoPath)
	if (string.find(CS.CommonVideoPlayer.videoPath,"M4OGAScutin"))~=nil then
		return
	end
	self.OnClickBG()
end
util.hotfix_ex(CS.CommonVideoPlayer,'OnClickBG',OnClickBG)
util.hotfix_ex(CS.CommonVideoPlayer,'OnClickUIBG',OnClickUIBG)