local util = require 'xlua.util'
xlua.private_accessible(CS.CommanderSpineAnimation)
local CommanderSpineAnimation_SortSpineSubGameObject = function(self)
	--根据顺序排序
	self.m_SpineSubGameObjectList:Clear();

	--插入身体背后的绑定点
	local HeadSpineAnimationSubmeshList = self.m_SkeletonAnimations[0].SubmeshRenderers;
	local BodySpineAnimationSubmeshList = self.m_SkeletonAnimations[1].SubmeshRenderers;
	local FootSpineAnimationSubmeshList = self.m_SkeletonAnimations[2].SubmeshRenderers;

	--//插入后绑点
	for i = 0, BodySpineAnimationSubmeshList.Length-1 do
		local submesh = BodySpineAnimationSubmeshList[i];
		self.m_SpineSubGameObjectList:AddLast(submesh.gameObject);
		if (submesh.name == "BodyBinder1") then
			break;
		end
	end

	--//插入后发
	for i = 0, HeadSpineAnimationSubmeshList.Length-1 do
		local submesh = HeadSpineAnimationSubmeshList[i];
		if (submesh.name == "FaceLayer") then
			break;
		end

		self.m_SpineSubGameObjectList:AddLast(submesh.gameObject);
	end
	--  
	--插入左手
	local isAfterBodyBinder1 = false;
	for i=0 ,BodySpineAnimationSubmeshList.Length-1 do
		local submesh = BodySpineAnimationSubmeshList[i];
		if isAfterBodyBinder1==false and submesh.name == "BodyBinder1" then
			isAfterBodyBinder1 = true;
			goto continue;
		end

		if isAfterBodyBinder1 == false then goto continue; end
		if (submesh.name == "BodyLayer") then
			break;
		end

		self.m_SpineSubGameObjectList:AddLast(submesh.gameObject);
		::continue::
	end

	--//插入脚
	for i = 0, FootSpineAnimationSubmeshList.Length-1 do
		local submesh = FootSpineAnimationSubmeshList[i];
		self.m_SpineSubGameObjectList:AddLast(submesh.gameObject);
	end


	--//插入身体
	local isAfterBodyLayer = false;
	for i = 1, BodySpineAnimationSubmeshList.Length-1 do
		local submesh = BodySpineAnimationSubmeshList[i];
		if (isAfterBodyLayer==false and submesh.name == "BodyLayer") then
			isAfterBodyLayer = true;
		end

		if (isAfterBodyLayer == false) then
			goto continue;
		end

		if (submesh.name == "RHandLayer") then
			break;
		end

		self.m_SpineSubGameObjectList:AddLast(submesh.gameObject);
		::continue::
	end

	--//插入头
	local isAfterFaceLayer = false;
	for i = 0, HeadSpineAnimationSubmeshList.Length-1 do
		local submesh = HeadSpineAnimationSubmeshList[i];
		if (isAfterFaceLayer == false and submesh.name == "FaceLayer") then
			isAfterFaceLayer = true;
		end

		if (isAfterFaceLayer == false) then goto continue; end

		self.m_SpineSubGameObjectList:AddLast(submesh.gameObject);
		::continue::
	end

	--//插入右手
	local isAfterRHandLayer = false;
	for i = 0, BodySpineAnimationSubmeshList.Length-1 do
		local submesh = BodySpineAnimationSubmeshList[i];
		if (isAfterRHandLayer == false and submesh.name == "RHandLayer") then
			isAfterRHandLayer = true;
		end

		if (isAfterRHandLayer == false) then goto continue; end


		self.m_SpineSubGameObjectList:AddLast(submesh.gameObject);
		::continue::
	end

	--//插入挂件
	for i = 0, self.m_BindAttachmentDataList.Count-1 do
		local attachmentData = self.m_BindAttachmentDataList[i];
		local current = self.m_SpineSubGameObjectList.First;
		while (current ~= nil) do
			if (current.Value.gameObject.name == attachmentData.BoneName) then
				self.m_SpineSubGameObjectList:AddAfter(current, attachmentData.Attachment);
				break;
			end

			current = current.Next;
		end


		if (current == nil) then
			CS.NDebug.LogError(string.Format("Can't insert Attachment {0} to Spine.Not found {1}.",
			attachmentData.AttachmentName, attachmentData.BoneName));
		end
	end
end 
xlua.hotfix(CS.CommanderSpineAnimation,'SortSpineSubGameObject',CommanderSpineAnimation_SortSpineSubGameObject)
