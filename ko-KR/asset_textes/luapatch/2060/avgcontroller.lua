local util = require 'xlua.util'
xlua.private_accessible(CS.AVGController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.Extensions)
local effectObj
local canvas
local InitDialogueContent = function(self)
	local lineContent = self.currentNode.Value.content
	local perfectStr
	local goodStr
	if string.match(lineContent,'<火焰>') ~= nil then
		local canvasObj = self.transform:Find("DialogueBox").gameObject;
		if(canvas == nil) then
			canvas = canvasObj:AddComponent(typeof(CS.UnityEngine.Canvas))
			canvas.overrideSorting = true;
			canvas.sortingOrder = 43;
		end
		effectObj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Prefabs/juyuan_huo"), self.transform, false)
		effectObj.transform.localScale = CS.UnityEngine.Vector3(100,100,100);

		local subs = string.gsub(lineContent, "<火焰>", "")
		self.currentNode.Value.content = string.gsub(subs, "</火焰>", "")
	end
	if string.match(lineContent,'<下雪>') ~= nil then
		local canvasObj = self.transform:Find("DialogueBox").gameObject;
		if(canvas == nil) then
			canvas = canvasObj:AddComponent(typeof(CS.UnityEngine.Canvas))
			canvas.overrideSorting = true;
			canvas.sortingOrder = 43;
		end
		effectObj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Effect/CJ_snow"), self.transform, false)
		effectObj.transform.localScale = CS.UnityEngine.Vector3(100,100,100);
		
		local subs = string.gsub(lineContent, "<下雪>", "")
		self.currentNode.Value.content = string.gsub(subs, "</下雪>", "")
	end
	if string.match(lineContent,'<火焰销毁>') ~= nil then
		if(effectObj ~= nil) then
			CS.UnityEngine.Object.Destroy(effectObj);
		end
		local subs = string.gsub(lineContent, "<火焰销毁>", "")
		self.currentNode.Value.content = string.gsub(subs, "</火焰销毁>", "")
	end
	self:InitDialogueContent()
end
util.hotfix_ex(CS.AVGController,'InitDialogueContent',InitDialogueContent)
