local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelLine)
local Init = function(self,spot0,spot1,startnode,endnode,ctrolpoint0,ctrolpoint1)
	self:Init(spot0,spot1,startnode,endnode,ctrolpoint0,ctrolpoint1);
	self.BezierRenderer.startWidth = 0.2;
	self.BezierRenderer.endWidth = 0.2;
	--self.BezierRenderer.numCornerVertices = 0;
end

local InitSpotLine = function(self,spot0,spot,startnode)
	if spot0 == nil then
		return;
	end
	self:InitSpotLine(spot0,spot,startnode);
	self.BezierRenderer.startWidth = 0.2;
	self.BezierRenderer.endWidth = 0.1;
	self.BezierRenderer.endColor = CS.UnityEngine.Color(1,1,1,0.3);
	self.BezierRenderer.material:SetFloat("_Alpha",0.6);
end

local ShowAddColor = function(self,play,addColor,delay)
	if self.missionEdit0 ~= nil then
		self:ShowAddColor(play,CS.UnityEngine.Color(1,0,0,1),delay);
	else
		self:ShowAddColor(play,addColor,delay);
	end
end

local RemoveAddColor = function(self,play,addColor,delay)
	self:RemoveAddColor(play,CS.UnityEngine.Color(1,0,0,1),delay);
end

local PlayShow = function(self,time,delay)
	self.BezierRenderer.material:SetFloat("_Control",0);	
	self:PlayShow(0.2,delay);
end

local InitPoli = function(self,spot0,spot1,startnode,endnode,pos)
	self:InitPoli(spot0,spot1,startnode,endnode,pos);
	self.alwaysDraw = true;
	if self.otherPoints.Count == 0 then
		self.BezierRenderer.startWidth = 0.9;
	else
		self.BezierRenderer.startWidth = 0.3;
	end
	self.BezierRenderer.endWidth = 0.3;
	--self.BezierRenderer.numCornerVertices = 0;
end

util.hotfix_ex(CS.OPSPanelLine,'Init',Init)
util.hotfix_ex(CS.OPSPanelLine,'InitSpotLine',InitSpotLine)
util.hotfix_ex(CS.OPSPanelLine,'ShowAddColor',ShowAddColor)
util.hotfix_ex(CS.OPSPanelLine,'RemoveAddColor',RemoveAddColor)
util.hotfix_ex(CS.OPSPanelLine,'PlayShow',PlayShow)
util.hotfix_ex(CS.OPSPanelLine,'InitPoli',InitPoli)
