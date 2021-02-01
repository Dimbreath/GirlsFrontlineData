local util = require 'xlua.util'
xlua.private_accessible(CS.AVGBackgroundController)
local ChangeBackgroundImage = function(self,imageBackground,bgNum,bgFrameNum)
	print('ChangeBackgroundImage');
	if self.profiles == nil then
		print('self.profiles == nil');
		local txt = CS.ResManager.GetObjectByPath("AVGTxt/profiles", ".txt");
		print(txt);
		self:Awake();
	end
	print(self.profiles);
	print(CS.AVGController.Instance.txtName);
	print(self.backgroundInfo);
	print(self.backgroundInfo.listEffect2);
	print(self.imageFrame)
	print(self.imageBackground)
	self:ChangeBackgroundImage(imageBackground,bgNum,bgFrameNum);
end
util.hotfix_ex(CS.AVGBackgroundController,'ChangeBackgroundImage',ChangeBackgroundImage)