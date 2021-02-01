local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainRankingUIController)

local OnClickTierDamage = function(self)
	self.mRankingListItemHolder.localPosition = CS.UnityEngine.Vector3(60,0,self.mRankingListItemHolder.localPosition.z)
	self:OnClickTierDamage()
end
local OnClickTierTime = function(self)
	self.mRankingListItemHolder.localPosition = CS.UnityEngine.Vector3(60,0,self.mRankingListItemHolder.localPosition.z)
	self:OnClickTierTime()
end
local OnClickReverse = function(self)
	self.mRankingListItemHolder.localPosition = CS.UnityEngine.Vector3(60,0,self.mRankingListItemHolder.localPosition.z)
	self:OnClickReverse()
end
util.hotfix_ex(CS.TargetTrainRankingUIController,'OnClickTierDamage',OnClickTierDamage)
util.hotfix_ex(CS.TargetTrainRankingUIController,'OnClickTierTime',OnClickTierTime)
util.hotfix_ex(CS.TargetTrainRankingUIController,'OnClickReverse',OnClickReverse)