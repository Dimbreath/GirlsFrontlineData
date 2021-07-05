local util = require 'xlua.util'
xlua.private_accessible(CS.FlightChessMainUIDiceNumberHolder)

local JoinTextAnim = function(self, anim, number)
	anim:Join(self.TextDiceNum:DOText(tostring(number),0.3,true,CS.DG.Tweening.ScrambleMode.Numerals))
end

util.hotfix_ex(CS.FlightChessMainUIDiceNumberHolder,'JoinTextAnim',JoinTextAnim)
