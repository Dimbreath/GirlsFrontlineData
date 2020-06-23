local util = require 'xlua.util'
xlua.private_accessible(CS.BattleSimulatorController)
--1.处理特定spine的偏移,血条参考位置读一次偏移量
--2.处理逻辑错误导致的召唤物血条意外显示
local Init = function(self)
	print('BattleSimulatorController')
	print(CS.ConfigData.highFPS)
	
	self:Init()
end

util.hotfix_ex(CS.BattleSimulatorController,'Init',Init)
