local util = require 'xlua.util'
xlua.private_accessible(CS.ReporterMessageReceiver)

local OnHideReporter = function(self)
	-- do nothing
end
xlua.hotfix(CS.ReporterMessageReceiver,'OnHideReporter',OnHideReporter)