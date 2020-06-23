local util = require 'xlua.util'
xlua.private_accessible(CS.SettingController)
util.hotfix_ex(CS.SettingController,'Awake',function(self)
		self:Awake()
		self.textClientVersion.text = string.format("%s\npatch%s_%s",self.textClientVersion.text,CS.ConfigData.clientVersion,'0001')
	end
)