local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelLine)
local Init = function(self,spot0,spot1,startnode,endnode,ctrolpoint0,ctrolpoint1)
	self:Init(spot0,spot1,startnode,endnode,ctrolpoint0,ctrolpoint1);
	self.BezierRenderer.startWidth = 0.2;
	self.BezierRenderer.endWidth = 0.2;
end

local InitSpotLine = function(self,spot0,spot,startnode)
	self:InitSpotLine(spot0,spot,startnode);
	self.BezierRenderer.startWidth = 0.2;
	self.BezierRenderer.endWidth = 0.1;
	self.BezierRenderer.endColor = CS.UnityEngine.Color(1,1,1,0.3);
end

local ShowAddColor = function(self,play,addColor,delay)
	self:ShowAddColor(play,CS.UnityEngine.Color(1,0,0,1),delay);
end

local RemoveAddColor = function(self,play,addColor,delay)
	self:RemoveAddColor(play,CS.UnityEngine.Color(1,0,0,1),delay);
end

local PlayShow = function(self,time,delay)
	self.BezierRenderer.material:SetFloat("_Control",0);	
	self:PlayShow(0.2,delay);
end

util.hotfix_ex(CS.OPSPanelLine,'Init',Init)
util.hotfix_ex(CS.OPSPanelLine,'InitSpotLine',InitSpotLine)
util.hotfix_ex(CS.OPSPanelLine,'ShowAddColor',ShowAddColor)
util.hotfix_ex(CS.OPSPanelLine,'RemoveAddColor',RemoveAddColor)
util.hotfix_ex(CS.OPSPanelLine,'PlayShow',PlayShow)
