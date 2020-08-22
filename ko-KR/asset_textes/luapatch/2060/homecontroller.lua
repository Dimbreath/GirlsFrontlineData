local util = require 'xlua.util'
xlua.private_accessible(CS.HomeController)
xlua.private_accessible(CS.WebCameraManager)
local ShowBackground_New = function(self, isShow)
	if CS.WebCameraManager.Instance ~= nil and isShow == false and CS.WebCameraManager.Instance.isScalePic == true then
		--CS.NDebug.LogError("lua ShowBackground return")
		return
	else
		--CS.NDebug.LogError("lua ShowBackground :" .. tostring(isShow))
		self:ShowBackground(isShow)
	end	
end

--首页图鉴里组织架构奖励领取红点
dicOrgStaffs = nil

local GetOrganizationStaffsDic_New = function()
	if dicOrgStaffs == nil then
		dicOrgStaffs = CS.OrganizationMapController.GetOrganizationStaffsDic()
	else
		--CS.NDebug.LogError("GetOrganizationStaffsDic_New dicOrgStaffs != nil")
	end	
	return dicOrgStaffs
end

local Home_Start_New = function(self)
	dicOrgStaffs = CS.OrganizationMapController.GetOrganizationStaffsDic()
	self:Start()
end

util.hotfix_ex(CS.HomeController,'ShowBackground',ShowBackground_New)
util.hotfix_ex(CS.HomeController,'Start',Home_Start_New)
util.hotfix_ex(CS.OrganizationMapController,'GetOrganizationStaffsDic',GetOrganizationStaffsDic_New)