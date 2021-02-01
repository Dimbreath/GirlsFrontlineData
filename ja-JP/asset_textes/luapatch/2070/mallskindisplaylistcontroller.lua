local util = require 'xlua.util'
xlua.private_accessible(CS.MallSkinDisplayListController)

function Split(szFullString, szSeparator)
	if(szFullString == nil) then
		return nil
	end
	local nFindStartIndex = 0
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
		end
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

local GetSkinThemeName_New = function(id)
	if id == -1 then
		return CS.Data.GetLang(71135)
	else
		local typeTxt = CS.Data.GetString("skin_type_txt")
		local nameList = Split(typeTxt,';')
		for i=1,#nameList do
			local temp = Split(nameList[i],':')
			local themeId = temp[1]
			--CS.NDebug.LogError("GetSkinThemeName_New"..themeId)

			local temp2 = Split(temp[2],',')
			local nameId = temp2[1]			
			--CS.NDebug.LogError("GetSkinThemeName_New"..nameId)

			if tonumber(themeId) == id then
				--CS.NDebug.LogError("GetSkinThemeName_New"..CS.Data.GetLang(tonumber(nameId)))
				return CS.Data.GetLang(tonumber(nameId))
			end
		end
	end
	return ""
end

util.hotfix_ex(CS.MallSkinDisplayListController,'GetSkinThemeName',GetSkinThemeName_New)


