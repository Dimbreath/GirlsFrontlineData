local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
xlua.private_accessible(CS.ResManager)
local Va11DrinkTable = {}
local Va11DrinkTableHidden = {}
local FlavorTable = {}
local TypeTable = {}
local InitialTable = {}
local FakeNameTable = {}
local TableStruct = nil

local currentAlcohol = nil --当前正在显示的饮品（详情）

local BtnPageNext = nil
local BtnPagePrev = nil

local AlcoholCount = {0,0,0,0,0}
local TotalCount = 0

local AlcoholName = {"Adelhyde","Bronson Ext","Pwd Delta","Flanergide","Karmotrine"}

local isIce = false
local isAge = false
local isFlairing = false
local forceBlend = false

local FlairingTime = 0
local TweenDelayTime = 0

local TweenDelayFlagBar = false
local TweenDelayFlagBar2 = false
local TweenDelayFlagBeer = false
local TweenDelayFlagOpen = false

local bottleState = -1 --目前的酒杯状态：0静置 1调制中 2调和中 3待上酒

local isReadyServe = -1 --调好酒的ID 如果是失败品则是0

local isReadyServeHuge = false --调好的酒是否是大杯

local ReadyServeKarmo = 0 --调好的酒里面的酒精量

local showBlendButton = false -- 是否显示调和按钮

--晃动手机相关
local lastshake = 0

local dst_acceleration_x = 0 
local dst_acceleration_y = 0 
local dst_acceleration_z = 0 
local last_dst_acceleration_x = 0 
local last_dst_acceleration_y = 0 
local last_dst_acceleration_z = 0 

--色彩信息
--用于给组件物体上色，里面存放的是Color

local AlcoholColorBG = {} 		-- 1-5：页签颜色 0：黑色 7 白色 8 灰色
local AlcoholColorProgress = {} -- 1-5：进度条颜色
local AlcoholColorNum = {}      -- 1-5：数字颜色

--用于给文字上色（富文本），里面存放的是色彩代码
local AlcoholColorName = {"#e0085b","#ca861a","#148bb8","#30890d","#16b78b"}
local AlcoholTextColorName = {"#e90024","#e9d000","#0089e9","#23ff19","#50eee2","#0060f1","#ea00da","#20e57c"}

--存储页签实例
local BartendingListItemList = {}
local ListSprite
local ListSpriteWinePic

--出现演出
local enterPerformance;
local materialEnterPerformance;
local enterPerformanceTime = 0;
local materialBottle;
local imageBottle;
local imageBottle1;
local enterPerformanceStarted = false; -- 是否已开始进入演出，在第一次Update之后设为true以防止

--Awake：初始化数据
Awake = function()

	
	-- 加载出现演出
	enterPerformance = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11_Dissolve",".prefab"));
	enterPerformance.transform:SetParent(self.transform,false);
	materialEnterPerformance = enterPerformance:GetComponent("ExImage").material;
	materialEnterPerformance:SetFloat("_SetTime",0);
	-- 隐藏酒瓶
	imageBottle = Bottle:GetComponent("ExImage");
	materialBottle = imageBottle.material;
	materialBottle:SetFloat("_Range",0.0);
	imageBottle.color = CS.UnityEngine.Color(1,1,1,0);
	imageBottle1 = Bottle1:GetComponent("ExImage");
	imageBottle1.color = CS.UnityEngine.Color(1,1,1,0);

	AlcoholName[1] = GetName(230127)
	AlcoholName[2] = GetName(230128)
	AlcoholName[3] = GetName(230129)
	AlcoholName[4] = GetName(230130)
	AlcoholName[5] = GetName(230131)

	FlavorTable[1] = GetName(230013)
	FlavorTable[2] = GetName(230014)
	FlavorTable[3] = GetName(230015)
	FlavorTable[4] = GetName(230016)
	FlavorTable[5] = GetName(230017)
	
	TypeTable[1] = GetName(230018)
	TypeTable[2] = GetName(230019)
	TypeTable[3] = GetName(230020)
	TypeTable[4] = GetName(230021)
	TypeTable[5] = GetName(230022)
	
	FakeNameTable[1] = "#u??!!"
	FakeNameTable[2] = "#y#bb="
	FakeNameTable[3] = "n#@##*"
	FakeNameTable[4] = "f@###"
	FakeNameTable[5] = "gt??!#"
	
	InitialTable[1] = GetName(230023)
	InitialTable[2] = GetName(230024)
	InitialTable[3] = GetName(230025)
	InitialTable[4] = GetName(230026)
	InitialTable[5] = GetName(230027)
	InitialTable[6] = GetName(230028)
	InitialTable[7] = GetName(230029)
	InitialTable[8] = GetName(230030)
	
	AlcoholColorBG[0] = GenColor(0,0,0,1)	
	AlcoholColorBG[1] = GenColor(162,33,54,255)
	AlcoholColorBG[2] = GenColor(202,151,8,255)
	AlcoholColorBG[3] = GenColor(50,144,188,255)
	AlcoholColorBG[4] = GenColor(8,115,3,255)
	AlcoholColorBG[5] = GenColor(21,217,203,255)

	AlcoholColorBG[7] = GenColor(1,1,1,1)
	AlcoholColorBG[8] = GenColor(255,255,255,77)
	
	
	AlcoholColorProgress[0] = GenColor(0,0,0,1)
	AlcoholColorProgress[1] = GenColor(233,0,36,255)
	AlcoholColorProgress[2] = GenColor(233,208,0,255)
	AlcoholColorProgress[3] = GenColor(0,137,233,255)
	AlcoholColorProgress[4] = GenColor(35,255,25,255)
	AlcoholColorProgress[5] = GenColor(80,238,226,255)
	AlcoholColorProgress[6] = GenColor(158,177,204,255)
	AlcoholColorProgress[9] = GenColor(0.16,0.16,0.16,1)
	AlcoholColorProgress[10] = GenColor(1,1,1,1)
	
	AlcoholColorNum[0] = GenColor(1,1,1,1)
	AlcoholColorNum[1] = GenColor(224,8,91,255)
	AlcoholColorNum[2] = GenColor(202,134,25,255)
	AlcoholColorNum[3] = GenColor(20,139,184,255)
	AlcoholColorNum[4] = GenColor(48,137,13,255)
	AlcoholColorNum[5] = GenColor(22,183,139,255)
	AlcoholColorNum[6] = GenColor(255,0,55,255)
	AlcoholColorNum[7] = GenColor(198,234,255,255)
	
	--[[ 
	Va11 饮品表格  字段说明： 
	ID 主键 Name名称 Code 资源图片名称（调酒完成后）
	
	RecipeDes：配方描述  支持以下方式进行填写简化 
	*[字符(1-5)]:[字符(1-9)或字符A（代表任选）] ：快捷转换调酒原料描述，自动附加颜色代码
	#[字符] 快捷转换加冰，陈化等描述，自动附加颜色代码
	！！！！！不要在这段文字中使用非上述原因的 * 字符与 # 字符！！！！！
	
	Des：风味描述
	ArrDes：词缀描述
	
	Recipe 5个数字（或字符A）。以逗号分隔：代表该酒的配方，填写A代表该数值任选，添加数量不影响配方，按原作仅用于5号原料。 
	支持大杯匹配，放入的原料全部是原本配方的2倍时也能调配出该酒
	
	Is_ice：是否需要加冰 Is_age是否需要陈化 Is_blended是否需要调和
	
	Flavor：该酒按照Flavor条件筛选时显示在哪一项下（以数字匹配）。如果填写Flavor列表长度外的数值（如0）则不会显示在任一项下
	Type：该酒按照Type条件筛选时显示在哪一项下（以数字匹配）。如果填写Type列表长度外的数值（如0）则不会显示在任一项下
	Initial：该酒按照Initial条件筛选时显示在哪一项下（以字符匹配）。虽然可以填写非列表内的数值但是没必要
	
	以下内容基本按照原作列表填写，有个问题是原作根本不是按照名称排序的，筛选出来的结果列表其顺序完全成谜
	]]--
	TableStruct = {Id = 1 ,Name = GetName(230043),Code = "VA11_BadTouch",
	RecipeDes = GetName(230044),
	Des = GetName(230045),
	ArrDes =GetName(230046),
	Recipe = "0,2,2,2,4",
	Is_ice = true,Is_age = false,Flavor = 3,Type = 4,Initial = 'B',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 2 ,Name = GetName(230071),Code = "VA11_Beer",
	RecipeDes = GetName(230072),
	Des = GetName(230073),
	ArrDes =GetName(230074),
	Recipe = "1,2,1,2,4",
	Is_ice = false,Is_age = false,Flavor = 5,Type = 3,Initial = 'B',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 3 ,Name = GetName(230075),Code = "VA11_BleedingJane",
	RecipeDes = GetName(230076),
	Des = GetName(230077),
	ArrDes =GetName(230078),
	Recipe = "0,1,3,3,0",
	Is_ice = false,Is_age = false,Flavor = 4,Type = 3,Initial = 'B',Is_blended = true}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 4 ,Name = GetName(230035),Code = "VA11_BloomLight",
	RecipeDes = GetName(230036),
	Des = GetName(230037),
	ArrDes =GetName(230038),
	Recipe = "4,0,1,2,3",
	Is_ice = true,Is_age = true,Flavor = 4,Type = 5,Initial = 'B',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 5 ,Name = GetName(230091),Code = "VA11_BlueFairy",
	RecipeDes = GetName(230092),
	Des = GetName(230093),
	ArrDes =GetName(230094),
	Recipe = "4,0,0,1,A",
	Is_ice = false,Is_age = true,Flavor = 1,Type = 1,Initial = 'B',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 6 ,Name = GetName(230047),Code = "VA11_Brandtini",
	RecipeDes = GetName(230048),
	Des = GetName(230049),
	ArrDes =GetName(230050),
	Recipe = "6,0,3,0,1",
	Is_ice = false,Is_age = true,Flavor = 1,Type = 4,Initial = 'B',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 7 ,Name = GetName(230051),Code = "VA11_CobaltVelvet",
	RecipeDes = GetName(230052),
	Des = GetName(230053),
	ArrDes =GetName(230054),
	Recipe = "2,0,0,3,5",
	Is_ice = true,Is_age = false,Flavor = 5,Type = 4,Initial = 'C',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 8 ,Name = GetName(230123),Code = "VA11_CreviceSpike",
	RecipeDes = GetName(230124),
	Des = GetName(230125),
	ArrDes =GetName(230126),
	Recipe = "0,0,2,4,A",
	Is_ice = false,Is_age = false,Flavor = 3,Type = 2,Initial = 'C',Is_blended = true}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 9 ,Name = GetName(230095),Code = "VA11_FluffyDream",
	RecipeDes = GetName(230096),
	Des = GetName(230097),
	ArrDes =GetName(230098),
	Recipe = "3,0,3,0,A",
	Is_ice = false,Is_age = true,Flavor = 3,Type = 1,Initial = 'F',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 10 ,Name = GetName(230055),Code = "VA11_FringeWeaver",
	RecipeDes = GetName(230056),
	Des = GetName(230057),
	ArrDes =GetName(230058),
	Recipe = "1,0,0,0,9",
	Is_ice = false,Is_age = true,Flavor = 5,Type = 4,Initial = 'F',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 11 ,Name = GetName(230079),Code = "VA11_FrothyWater",
	RecipeDes = GetName(230080),
	Des = GetName(230081),
	ArrDes =GetName(230082),
	Recipe = "1,1,1,1,0",
	Is_ice = false,Is_age = true,Flavor = 5,Type = 3,Initial = 'F',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 12 ,Name = GetName(230031),Code = "VA11_GrizzlyTemple",
	RecipeDes = GetName(230032),
	Des = GetName(230033),
	ArrDes =GetName(230034),
	Recipe = "3,3,3,0,1",
	Is_ice = false,Is_age = false,Flavor = 2,Type = 5,Initial = 'G',Is_blended = true}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 13 ,Name = GetName(230107),Code = "VA11_GutPunch",
	RecipeDes = GetName(230108),
	Des = GetName(230109),
	ArrDes =GetName(230110),
	Recipe = "0,5,0,1,A",
	Is_ice = false,Is_age = true,Flavor = 2,Type = 2,Initial = 'G',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 14 ,Name = GetName(230119),Code = "VA11_Marsblast",
	RecipeDes = GetName(230120),
	Des = GetName(230121),
	ArrDes =GetName(230122),
	Recipe = "0,6,1,4,2",
	Is_ice = false,Is_age = false,Flavor = 4,Type = 2,Initial = 'M',Is_blended = true}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 15 ,Name = GetName(230059),Code = "VA11_MercuryBlast",
	RecipeDes = GetName(230060),
	Des = GetName(230061),
	ArrDes =GetName(230062),
	Recipe = "1,1,3,3,2",
	Is_ice = true,Is_age = false,Flavor = 3,Type = 4,Initial = 'M',Is_blended = true}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 16 ,Name = GetName(230103),Code = "VA11_Moonblast",
	RecipeDes = GetName(230104),
	Des = GetName(230105),
	ArrDes =GetName(230106),
	Recipe = "6,0,1,1,2",
	Is_ice = true,Is_age = false,Flavor = 1,Type = 1,Initial = 'M',Is_blended = true}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 17 ,Name = GetName(230063),Code = "VA11_PianoMan",
	RecipeDes = GetName(230064),
	Des = GetName(230065),
	ArrDes =GetName(230066),
	Recipe = "2,3,5,5,3",
	Is_ice = true,Is_age = false,Flavor = 0,Type = 5,Initial = 'P',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 18 ,Name = GetName(230067),Code = "VA11_PianoWoman",
	RecipeDes = GetName(230068),
	Des = GetName(230069),
	ArrDes =GetName(230070),
	Recipe = "5,5,2,3,3",
	Is_ice = false,Is_age = true,Flavor = 1,Type = 5,Initial = 'P',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 19 ,Name = GetName(230111),Code = "VA11_Piledriver",
	RecipeDes = GetName(230112),
	Des = GetName(230113),
	ArrDes =GetName(230114),
	Recipe = "0,3,0,3,4",
	Is_ice = false,Is_age = false,Flavor = 2,Type = 2,Initial = 'P',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 20 ,Name = GetName(230087),Code = "VA11_SparkleStar",
	RecipeDes = GetName(230088),
	Des = GetName(230089),
	ArrDes =GetName(230090),
	Recipe = "2,0,1,0,A",
	Is_ice = false,Is_age = true,Flavor = 1,Type = 1,Initial = 'S',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 21 ,Name = GetName(230083),Code = "VA11_SugarRush",
	RecipeDes = GetName(230084),
	Des = GetName(230085),
	ArrDes =GetName(230086),
	Recipe = "2,0,1,0,A",
	Is_ice = false,Is_age = false,Flavor = 1,Type = 1,Initial = 'S',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 22 ,Name = GetName(230099),Code = "VA11_SunshineCloud",
	RecipeDes = GetName(230100),
	Des = GetName(230101),
	ArrDes =GetName(230102),
	Recipe = "2,2,0,0,A",
	Is_ice = true,Is_age = false,Flavor = 2,Type = 1,Initial = 'S',Is_blended = true}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 23 ,Name = GetName(230115),Code = "VA11_Suplex",
	RecipeDes = GetName(230116),
	Des = GetName(230117),
	ArrDes =GetName(230118),
	Recipe = "0,4,0,3,3",
	Is_ice = true,Is_age = false,Flavor = 2,Type = 2,Initial = 'S',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	TableStruct = {Id = 24 ,Name = GetName(230039),Code = "VA11_ZenStar",
	RecipeDes = GetName(230040),
	Des = GetName(230041),
	ArrDes =GetName(230042),
	Recipe = "4,4,4,4,4",
	Is_ice = true,Is_age = false,Flavor = 3,Type = 5,Initial = 'Z',Is_blended = false}
	Va11DrinkTable[TableStruct.Id] = TableStruct
	
	--[[ 隐秘菜单 序号ID接前表，隐秘表中ID减去前表总长度---------------------------------------
	填写规则完全同前，但是放在这个列表下的酒不会被显示在饮品列表里面，可以正常调出和进行后续交互
	考虑把联动用不上的酒放在这里？
	]]--
	TableStruct = {Id = 25 ,Name = "Flaming Moai",Code = "VA11_FlamingMoai",
	RecipeDes = "",
	Des = "",
	ArrDes ="",
	Recipe = "1,1,2,3,5",
	Is_ice = false,Is_age = false,Flavor = 0,Type = 0,Initial = 'F',Is_blended = false}
	Va11DrinkTableHidden[1] = TableStruct
	
	--初始化随机数
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
end
--Start: 加载组件
Start = function()
	print("Va11Start")
	InitLeftPart()
	InitRightPart()
	BtnPageNext = DetailPageNext:GetComponent("ExButton")
	BtnPagePrev = DetailPagePrev:GetComponent("ExButton")

	PlaySFX("reset")
	CleanBottle()
	--添加监听事件
	BtnSelectName:GetComponent("Button").onClick:AddListener(function()
		--关闭界面
		PlaySFX("select_type")
		WelcomePage:SetActive(false)
		SetTopButtons(true,false,false)
		DestroyChildren(ByNameNode.transform:GetChild(0))
		DestroyChildren(ByNameNode.transform:GetChild(1))
		DestroyChildren(ByOtherNode.transform)
		WineListNode:SetActive(true)
		ValueNode:SetActive(false)
		--SelectTitle:GetComponent("Text").text = "按首字母选择"
		ByNameNode:SetActive(true)
		ByOtherNode:SetActive(false)
		WineIntroductionNode:SetActive(false)
		--生成列表
		for i=1,#InitialTable do
			local model =  CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11WineListKeyItem"))
			if i % 2 == 1 then
				model.transform:SetParent(ByNameNode.transform:GetChild(0), false)
			else
				model.transform:SetParent(ByNameNode.transform:GetChild(1), false)
			end
			model:SetActive(true)
			model:GetComponentInChildren(typeof(CS.ExText)).text = InitialTable[i]
			
			--子物体选中
			model:GetComponent("ExButton").onClick:AddListener(function()
				PlaySFX("vaild_select")
				for j=0,ByNameNode.transform:GetChild(0).childCount-1 do
					if j == (i+1)/2 -1 then
						ByNameNode.transform:GetChild(0):GetChild(j):GetChild(1).gameObject:SetActive(true)
					else
						ByNameNode.transform:GetChild(0):GetChild(j):GetChild(1).gameObject:SetActive(false)
					end
				end
				for j=0,ByNameNode.transform:GetChild(1).childCount-1 do
					if j == i/2 -1 then
						ByNameNode.transform:GetChild(1):GetChild(j):GetChild(1).gameObject:SetActive(true)
					else
						ByNameNode.transform:GetChild(1):GetChild(j):GetChild(1).gameObject:SetActive(false)
					end
				end
				DestroyChildren(ValueNode.transform:GetChild(0))
				ValueNode:SetActive(true)
				for j=1,#Va11DrinkTable do
					if Va11DrinkTable[j].Initial == InitialTable[i] then
						local submodel =  CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11WineListValueItem"))
						submodel.transform:SetParent(ValueNode.transform:GetChild(0), false);
						submodel:SetActive(true)
						submodel:GetComponentInChildren(typeof(CS.ExText)).text = Va11DrinkTable[j].Name
						submodel:GetComponent("ExButton").onClick:AddListener(function()
							PlaySFX("vaild_select")										
							ShowAlcoholDetail(j)
						end)
					end
				end
			end)
		end
		
	end)
	BtnSelectFlavor:GetComponent("Button").onClick:AddListener(function()
		PlaySFX("select_type")
		WelcomePage:SetActive(false)
		SetTopButtons(false,true,false)
		DestroyChildren(ByNameNode.transform:GetChild(0))
		DestroyChildren(ByNameNode.transform:GetChild(1))
		DestroyChildren(ByOtherNode.transform)
		WineListNode:SetActive(true)
		ValueNode:SetActive(false)
		--SelectTitle:GetComponent("Text").text = "按口味选择"
		ByNameNode:SetActive(false)
		ByOtherNode:SetActive(true)
		WineIntroductionNode:SetActive(false)
		--生成列表
		for i=1,#FlavorTable do
			local model =  CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11WineListKeyItem"))
			model.transform:SetParent(ByOtherNode.transform, false);
			model:SetActive(true)
			local modelRect = model:GetComponent("RectTransform")
			modelRect.sizeDelta = CS.UnityEngine.Vector2(#FlavorTable[i] *16 ,modelRect.sizeDelta.y)
			model:GetComponentInChildren(typeof(CS.ExText)).text = FlavorTable[i]
			--子物体选中
			model:GetComponent("ExButton").onClick:AddListener(function()
				PlaySFX("vaild_select")
				for j=0,ByOtherNode.transform.childCount-1 do
					if j == i-1 then
						ByOtherNode.transform:GetChild(j):GetChild(1).gameObject:SetActive(true)
					else
						ByOtherNode.transform:GetChild(j):GetChild(1).gameObject:SetActive(false)
					end
				end
				DestroyChildren(ValueNode.transform:GetChild(0))
				ValueNode:SetActive(true)
				for j=1,#Va11DrinkTable do
					if Va11DrinkTable[j].Flavor == i then
						local submodel = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11WineListValueItem"))
						submodel.transform:SetParent(ValueNode.transform:GetChild(0), false);
						submodel:SetActive(true)
						submodel:GetComponentInChildren(typeof(CS.ExText)).text = Va11DrinkTable[j].Name
						submodel:GetComponent("Button").onClick:AddListener(function()
							PlaySFX("vaild_select")
							ShowAlcoholDetail(j)
						end)
					end
				end
			end)
		end		
	end)
	BtnSelectType:GetComponent("Button").onClick:AddListener(function()
		PlaySFX("select_type")
		WelcomePage:SetActive(false)
		SetTopButtons(false,false,true)
		DestroyChildren(ByNameNode.transform:GetChild(0))
		DestroyChildren(ByNameNode.transform:GetChild(1))
		DestroyChildren(ByOtherNode.transform)
		WineListNode:SetActive(true)
		ValueNode:SetActive(false)
		ByNameNode:SetActive(false)
		ByOtherNode:SetActive(true)
		WineIntroductionNode:SetActive(false)
		--生成列表
		for i=1,#TypeTable do
			local model =  CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11WineListKeyItem"))
			model.transform:SetParent(ByOtherNode.transform, false);
			model:SetActive(true)

			local modelRect = model:GetComponent("RectTransform")
			modelRect.sizeDelta = CS.UnityEngine.Vector2(#TypeTable[i]*16 ,modelRect.sizeDelta.y)
			model:GetComponentInChildren(typeof(CS.ExText)).text = TypeTable[i]
			--子物体选中
			model:GetComponent("ExButton").onClick:AddListener(function()
				PlaySFX("vaild_select")
				for j=0,ByOtherNode.transform.childCount-1 do
					if j == i-1 then
						ByOtherNode.transform:GetChild(j):GetChild(1).gameObject:SetActive(true)
					else
						ByOtherNode.transform:GetChild(j):GetChild(1).gameObject:SetActive(false)
					end
				end
				DestroyChildren(ValueNode.transform:GetChild(0))
				ValueNode:SetActive(true)
				for j=1,#Va11DrinkTable do
					if Va11DrinkTable[j].Type == i then
						local submodel = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11WineListValueItem"))
						submodel.transform:SetParent(ValueNode.transform:GetChild(0), false);
						submodel:SetActive(true)
						submodel:GetComponentInChildren(typeof(CS.ExText)).text = Va11DrinkTable[j].Name
						--子物体选中
						submodel:GetComponent("Button").onClick:AddListener(function()
							PlaySFX("vaild_select")
							ShowAlcoholDetail(j)
						end)
					end
				end
			end)
		end		
	end)
	BtnPagePrev.onClick:AddListener(function()
		if ValueNode.activeSelf then
			PlaySFX("vaild_select")
			ShowAlcoholDetail(currentAlcohol-1)
		end
		
	end)
	BtnPageNext.onClick:AddListener(function()
		if ValueNode.activeSelf then
			PlaySFX("vaild_select")
			ShowAlcoholDetail(currentAlcohol+1)
		end
	end)
	BtnIce:GetComponent("Button").onClick:AddListener(function()
		if isIce then
			PlaySFX("invaild_press")
		else
			PlaySFX("ice")
		end
		SetIsIce(not isIce)		
	end)
	BtnAge:GetComponent("Button").onClick:AddListener(function()
		if isAge then
			PlaySFX("invaild_press")
		else
			PlaySFX("age")
		end
		SetIsAge(not isAge)
	end)
	BartendingListItemList[1]:GetComponent("Button").onClick:AddListener(function()
		OnClickAlcohol(1)
	end)
	BartendingListItemList[2]:GetComponent("Button").onClick:AddListener(function()
		OnClickAlcohol(2)
	end)
	BartendingListItemList[3]:GetComponent("Button").onClick:AddListener(function()
		OnClickAlcohol(3)
	end)
	BartendingListItemList[4]:GetComponent("Button").onClick:AddListener(function()
		OnClickAlcohol(4)
	end)
	BartendingListItemList[5]:GetComponent("Button").onClick:AddListener(function()
		OnClickAlcohol(5)
	end)
	BtnRemake:GetComponent("Button").onClick:AddListener(function()
		if TotalCount >0 or isIce or isAge then
			PlaySFX("reset")
		else
			PlaySFX("invaild_press")
		end
		CleanBottle()
		AddQuantityCountNode:SetActive(true)
		Tex_WineName:SetActive(false)
	end)	
	BtnFlair:GetComponent("Button").onClick:AddListener(function()
		if isReadyServe >= 0 then	
			return					
		else
			if isFlairing then
				EndFlairing()
				ChangeBtnFlairState(3)
				PlaySFX("flair")
			else
				if TotalCount > 0 then
					forceBlend = false
					FlairingTime = 0
					isFlairing = true
					ChangeBtnFlairState(2)
					PlaySFX("flair")
				else
					PlaySFX("invaild_press")
				end
			end
		end
	end)
	BtnBlend:GetComponent("Button").onClick:AddListener(function()
		if isReadyServe >= 0 then	
			return					
		else
			if isFlairing then
				return
			else
				if TotalCount > 0 then
					forceBlend = true
					FlairingTime = 0
					isFlairing = true
					ChangeBtnFlairState(2)
					PlaySFX("flair")
				else
					PlaySFX("invaild_press")
				end
			end
		end
	end)
	Btn_GetWine:GetComponent("Button").onClick:AddListener(function()
		if isReadyServe >= 0 then	
			if isReadyServe == 0 then
				--失败品
				PlaySFX("invaild_press")
				--TODO:提示不想要
				--CS.CommonController.LightMessageTips("这酒不太行")
			else
				--判断上酒是否满足顾客喜好...
				local perfectFlag = false
				local goodFlag = false
				
				--perfect
				local perfectStr = CS.UnityEngine.PlayerPrefs.GetString('VA11Perfect')
				if perfectStr ~= "-1" then
					local perfectList = Split(perfectStr,',')			
					for i=1,#perfectList do	
						if tostring(isReadyServe) == perfectList[i] then
							perfectFlag = true
							break
						end
					end
				end
				if perfectFlag then
					PlaySFX("match")
					CS.UnityEngine.PlayerPrefs.SetString('VA11Branch',"1")
					CS.UnityEngine.Object.Destroy(self.gameObject)
				else
					--good
					local goodStr = CS.UnityEngine.PlayerPrefs.GetString('VA11Good')
					if goodStr ~= "-1" then
						local goodList = Split(goodStr,',')
						for i=1,#goodList do
							if tostring(isReadyServe) == goodList[i] then
								goodFlag = true
								break
							end
						end
					end
					if goodFlag then	
						PlaySFX("match")
						CS.UnityEngine.PlayerPrefs.SetString('VA11Branch',"2")		
						CS.UnityEngine.Object.Destroy(self.gameObject)
					else
						--TODO:提示不想要、
						PlaySFX("invaild_press")
						CS.CommonController.LightMessageTips(GetName(230137))					
					end
				end	
				
			end					
		else
			return
		end
	end)
	
end
--Update: 计算摇酒时间
Update = function()
	if isFlairing then 
		FlairingTime = FlairingTime + CS.UnityEngine.Time.deltaTime
		--调和		
		
		if FlairingTime > 3 or (FlairingTime > 0 and forceBlend)  then
			SetBottleState(2,0)
		else
			SetCurAccel(CS.UnityEngine.Input.acceleration)
			if lastshake > 1.5 then
				FlairingTime = 3.1
				SetBottleState(2,0)
			else
				SetBottleState(1,0)
			end
		end
	end
	if (not TweenDelayFlagOpen) then
		TweenDelayTime = TweenDelayTime + CS.UnityEngine.Time.deltaTime
	end
	if (not TweenDelayFlagBar) and TweenDelayTime > 1.325 then
		TweenDelayFlagBar = true
		Tween_Bar:GetComponent("ExImage").color = AlcoholColorBG[7]
		
	end
	if (not TweenDelayFlagBeer) and TweenDelayTime > 1.525 then
		TweenDelayFlagBeer = true
		Tween_Beer:GetComponent("TweenPlay"):DoTween()
	end
	if (not TweenDelayFlagBar2) and TweenDelayTime > 1.625 then
		TweenDelayFlagBar2 = true
		Tween_Bar:GetComponent("TweenPlay"):DoTween()
	end
	if (not TweenDelayFlagOpen) and TweenDelayTime > 1.825 then
		TweenDelayFlagOpen = true
		Tween_Open:GetComponent("TweenPlay"):DoTween()
		
	end
	if enterPerformanceStarted then
		if enterPerformanceTime < 1.7 then
			if enterPerformanceTime < 1.0 then
				enterPerformanceTime = enterPerformanceTime + CS.UnityEngine.Time.deltaTime;
				if enterPerformanceTime >= 1.0 then
					CS.UnityEngine.Object.Destroy(enterPerformance);
					materialEnterPerformance = nil;
					enterPerformance = nil;
					-- 电视机闪光特效
					local gobjTV = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/SAIBO_UI_tiaojiu"));
					gobjTV.transform:SetParent(self.transform:Find("LeftArea/Frame"),true);
					gobjTV.transform.localPosition = CS.UnityEngine.Vector3(0,100,0);
					gobjTV = nil;
				else
					-- 方块进入0.2~1.0
					if enterPerformanceTime >= 0.2 then
						materialEnterPerformance:SetFloat("_SetTime",(enterPerformanceTime-0.2)/0.8);
					end
				end
			else
				enterPerformanceTime = enterPerformanceTime + CS.UnityEngine.Time.deltaTime;
				if enterPerformanceTime >= 1.7 then
					imageBottle = nil;
					imageBottle1 = nil;
					materialBottle:SetFloat("_Range",0);
					materialBottle = nil;
				else
					-- 渐显1.1~1.5
					if enterPerformanceTime > 1.1 and enterPerformanceTime < 1.5 then
						imageBottle.color = CS.UnityEngine.Color(1,1,1,(enterPerformanceTime-1.1)/0.4);
						imageBottle1.color = CS.UnityEngine.Color(1,1,1,(enterPerformanceTime-1.1)/0.4);
					else
						imageBottle.color = CS.UnityEngine.Color(1,1,1,1);
						imageBottle1.color = CS.UnityEngine.Color(1,1,1,1);
					end
					-- 扭曲 1.3~1.7
					if enterPerformanceTime >= 1.3 then
						materialBottle:SetFloat("_Range",0.12*(1.7-enterPerformanceTime)/0.4);
					end
				end
			end
		end
	else
		enterPerformanceStarted = true;
		enterPerformanceTime = 0.0;
		WelcomePage:GetComponent("TweenPlay").enabled = true;
	end
end
 
--显示饮品详情
function ShowAlcoholDetail(index)
	SetTopButtons(false,false,false)
	currentAlcohol = index
	WineListNode:SetActive(false)
	WineIntroductionNode:SetActive(true)
	DetailName:GetComponent("Text").text = Va11DrinkTable[index].Name
	DetaiFormula:GetComponent("Text").text = regexAlcohol(Va11DrinkTable[index].RecipeDes)
	DetailDes:GetComponent("Text").text = Va11DrinkTable[index].Des
	DetailArr:GetComponent("Text").text = Va11DrinkTable[index].ArrDes
	DetailPageMark:GetComponent("Text").text = index.."/"..#Va11DrinkTable
	if(index == #Va11DrinkTable) then
		BtnPageNext.interactable = false
	else
		BtnPageNext.interactable = true
	end
	if(index == 1) then
		BtnPagePrev.interactable = false
	else
		BtnPagePrev.interactable = true
	end
end
--便捷函数，循环摧毁物体
function DestroyChildren(transform)
	for i=0,transform.childCount-1 do
		CS.UnityEngine.Object.Destroy(transform:GetChild(i).gameObject)
	end
	return 
end
function OnClickAlcohol(Type)
	if AlcoholCount[Type] >=20 or TotalCount >= 20 or bottleState ~= 0 then
		return
	end
	PlaySFX("pour")
	ChangeCount(Type,false)
end
function ChangeCount(Type,isClear)
	if isClear then
		if TotalCount ~= 0 then
			PlayBottleEffect(10)
		end
		AlcoholCount = {0,0,0,0,0}
		TotalCount = 0

	else
		AlcoholCount[Type] =AlcoholCount[Type]+1
		TotalCount = TotalCount+1
		PlayBottleEffect(Type)
	end
	SetCounter(AddQuantityCountNode.transform,TotalCount,6)
	if Type == 1 or Type == 0 then
		SetCounter(BartendingListItemList[1].transform:GetChild(2),AlcoholCount[1],1)
		ChangeBartendingItem(1)
	end
	if Type == 2 or Type == 0 then
		SetCounter(BartendingListItemList[2].transform:GetChild(2),AlcoholCount[2],2)
		ChangeBartendingItem(2)
	end
	if Type == 3 or Type == 0 then
		SetCounter(BartendingListItemList[3].transform:GetChild(2),AlcoholCount[3],3)
		ChangeBartendingItem(3)
	end
	if Type == 4 or Type == 0 then
		SetCounter(BartendingListItemList[4].transform:GetChild(2),AlcoholCount[4],4)
		ChangeBartendingItem(4)
	end
	if Type == 5 or Type == 0 then
		SetCounter(BartendingListItemList[5].transform:GetChild(2),AlcoholCount[5],5)
		ChangeBartendingItem(5)
	end

	ChangeBtnFlairState(1)
end
-- 0 静止 1 调制 2 调和 3上酒（+酒编号，失败了是-1）
function SetBottleState(state,beverage)
	local BottleImage = Bottle:GetComponent("ExImage")
	local BottleTween = Bottle:GetComponent("TweenPlay")
	local BottleShadeTween = BottleShade:GetComponent("TweenPlay")
	if state == 0 and bottleState ~= state then
		bottleState = state
		--BottleImage.color = CS.UnityEngine.Color(1,1,1,1)
		ReSetAccel()
		if BottleTween.enabled == true then
			BottleTween.enabled = false
			BottleTween.duration = 0
			BottleTween.fromThree = CS.UnityEngine.Vector3(0,0,0)
			BottleTween.toThree = CS.UnityEngine.Vector3(0,0,0)
			BottleTween.enabled = true
			BottleTween.enabled = false
		end
		if BottleShadeTween.enabled == true then
			BottleShadeTween.enabled = false
			BottleShadeTween.duration = 0
			BottleShadeTween.fromThree = CS.UnityEngine.Vector3(0,0,0)
			BottleShadeTween.toThree = CS.UnityEngine.Vector3(0,0,0)
			BottleShadeTween.enabled = true
			BottleShadeTween.enabled = false
		end
		Bottle.transform.localEulerAngles = CS.UnityEngine.Vector3(0,0,0)
		BottleShade.transform.localEulerAngles = CS.UnityEngine.Vector3(0,0,0)
	end
	if state == 1 and bottleState ~= state then
		bottleState = state
		
		BottleTween.enabled = false
		BottleTween.fromThree = CS.UnityEngine.Vector3(0,0,25)
		BottleTween.toThree = CS.UnityEngine.Vector3(0,0,-25)
		BottleTween.duration = 0.25
		BottleTween.enabled = true
		
		BottleShadeTween.enabled = false
		BottleShadeTween.fromThree = CS.UnityEngine.Vector3(0,0,25)
		BottleShadeTween.toThree = CS.UnityEngine.Vector3(0,0,-25)
		BottleShadeTween.duration = 0.25
		BottleShadeTween.enabled = true
		--BottleImage.color = CS.UnityEngine.Color(0,1,1,1)
	end
	if state == 2 and bottleState ~= state then
		bottleState = state
		--BottleImage.color = CS.UnityEngine.Color(0,0,1,1)
		BottleTween.enabled = false
		BottleTween.fromThree = CS.UnityEngine.Vector3(0,0,25)
		BottleTween.toThree = CS.UnityEngine.Vector3(0,0,-25)
		BottleTween.duration = 0.125
		BottleTween.enabled = true
		
		BottleShadeTween.enabled = false
		BottleShadeTween.fromThree = CS.UnityEngine.Vector3(0,0,25)
		BottleShadeTween.toThree = CS.UnityEngine.Vector3(0,0,-25)
		BottleShadeTween.duration = 0.125
		BottleShadeTween.enabled = true
		
		ReSetAccel()
		--BottleTween:Play()
	end
	if state == 3 and bottleState ~= state then
		ReSetAccel()
		bottleState = state		
		if BottleTween.enabled == true then
			BottleTween.enabled = false
			BottleTween.duration = 0
			BottleTween.fromThree = CS.UnityEngine.Vector3(0,0,0)
			BottleTween.toThree = CS.UnityEngine.Vector3(0,0,0)
			BottleTween.enabled = true
			BottleTween.enabled = false
		end
		
		if BottleShadeTween.enabled == true then
			BottleShadeTween.enabled = false
			BottleShadeTween.duration = 0
			BottleShadeTween.fromThree = CS.UnityEngine.Vector3(0,0,0)
			BottleShadeTween.toThree = CS.UnityEngine.Vector3(0,0,0)
			BottleShadeTween.enabled = true
			BottleShadeTween.enabled = false
		end
		Bottle.transform.localEulerAngles = CS.UnityEngine.Vector3(0,0,0)
		BottleShade.transform.localEulerAngles = CS.UnityEngine.Vector3(0,0,0)
		--BottleTween:Stop()
		if beverage < 1 then
			--BottleImage.color = CS.UnityEngine.Color(0.5,0.5,0.5,1)
		else
			--TODO:加载图片资源
			--BottleImage.color = CS.UnityEngine.Color (1, 0.92, 0.016, 1)
		end
	end
end
function EndFlairing(Type)
	isFlairing = false

	--匹配饮品...
	local Ans = MatchBeverage()
	AddQuantityCountNode:SetActive(false)
	Tex_WineName:SetActive(true)
	SetBottleState(3,Ans)
	WinePic:SetActive(true)
	Bottle:SetActive(false)
	BottleShade:SetActive(false)
	--没匹配到
	if Ans <= 0 then
		local rand = math.random(1,#FakeNameTable)
		Tex_WineName:GetComponent("Text").text = FakeNameTable[rand]
		Tex_WineName:GetComponent("Text").color = AlcoholColorNum[6]
		isReadyServe = 0
		WinePic:GetComponent("ExImage").sprite = GetIcon("VA11_Fail")
		PlayResultAnim(false)
	else
		Tex_WineName:GetComponent("Text").color = AlcoholColorNum[7]
		if Ans > #Va11DrinkTable then
			Tex_WineName:GetComponent("Text").text = Va11DrinkTableHidden[Ans-#Va11DrinkTable].Name
			WinePic:GetComponent("ExImage").sprite = GetIcon(Va11DrinkTableHidden[Ans-#Va11DrinkTable].Code)
		else
			Tex_WineName:GetComponent("Text").text = Va11DrinkTable[Ans].Name
			WinePic:GetComponent("ExImage").sprite = GetIcon(Va11DrinkTable[Ans].Code)
		end
		isReadyServe = Ans
		
		PlayResultAnim(true)
	end
end
--匹配数据表 尝试找出符合条件的饮品...
function MatchBeverage()
	local isBlended = (FlairingTime > 3 or forceBlend)
	for i=1,#Va11DrinkTable do
		if Va11DrinkTable[i].Is_ice == isIce then
			if Va11DrinkTable[i].Is_age == isAge then
				if Va11DrinkTable[i].Is_blended == isBlended then		
					local matchFlag =true
					local SplitArray = Split(Va11DrinkTable[i].Recipe,',')
					local sizeFlag = false
					local firstFlag = true
					for j=1,#SplitArray do
						if SplitArray[j] == 'A' then
						else			
							if SplitArray[j]~='0' and firstFlag then
								sizeFlag = (math.fmod(AlcoholCount[j],2) == 0 and SplitArray[j] == tostring(math.ceil(AlcoholCount[j]/2)))
								firstFlag = false
							end
							if (SplitArray[j] == tostring(AlcoholCount[j]) and not sizeFlag) or (SplitArray[j] == tostring(math.ceil(AlcoholCount[j]/2)) and sizeFlag) then
								
							else								
								matchFlag = false
								break
							end
						end
					end
					if matchFlag then
						isReadyServeHuge = sizeFlag
						ReadyServeKarmo = AlcoholCount[5]
						return i
					end
				end
			end
		end
	
	end
	for i=1,#Va11DrinkTableHidden do
		if Va11DrinkTableHidden[i].Is_ice == isIce then
			if Va11DrinkTableHidden[i].Is_age == isAge then
				if Va11DrinkTableHidden[i].Is_blended == isBlended then		
					local matchFlag =true
					local SplitArray = Split(Va11DrinkTableHidden[i].Recipe,',')
					local sizeFlag = false
					local firstFlag = true
					for j=1,#SplitArray do
						if SplitArray[j] == 'A' then
						else			
							if SplitArray[j]~='0' and firstFlag then
								sizeFlag = (math.fmod(AlcoholCount[j],2) == 0 and SplitArray[j] == tostring(math.ceil(AlcoholCount[j]/2)))
								firstFlag = false
							end
							if (SplitArray[j] == tostring(AlcoholCount[j]) and not sizeFlag) or (SplitArray[j] == tostring(math.ceil(AlcoholCount[j]/2)) and sizeFlag) then
								
							else								
								matchFlag = false
								break
							end
						end
					end
					if matchFlag then
						isReadyServeHuge = sizeFlag
						ReadyServeKarmo = AlcoholCount[5]
						return i+#Va11DrinkTable
					end
				end
			end
		end
	
	end
	return -1;
end
--根据Count 设置counterzone状态 写死了以10个子物体的状态运作 
function SetCounter(counterZone,count,colorNumber)
	local transform = counterZone
	local falseNum = 0
	if colorNumber == 6 then
		falseNum = 9
	end	
	local mkII = 0
	if count > 10 then 
		mkII = count - 10
		count = 10
	end
	for i=0,transform.childCount-1 do
		
		local counter = transform:GetChild(i)
		local counter1 = counter:GetChild(0).gameObject:GetComponent("ExImage")
		local counter2 = counter:GetChild(1).gameObject:GetComponent("ExImage")
		if mkII > 0 then
			mkII =mkII -1
			count = count -1
			counter1.color = AlcoholColorProgress[colorNumber]
			counter2.color = AlcoholColorProgress[colorNumber]
		else
			if count > 0 then
				count = count -1
				counter1.color = AlcoholColorProgress[colorNumber]
				counter2.color = AlcoholColorProgress[falseNum]
			else
				counter1.color = AlcoholColorProgress[falseNum]
				counter2.color = AlcoholColorProgress[falseNum]
			end
		end
	end
	
end
--清除数据
function CleanBottle()
	isReadyServe = -1
	isReadyServeHuge = false
	ReadyServeKarmo = 0
	ChangeCount(0,true)
	SetIsIce(false)
	SetIsAge(false)
	isFlairing = false
	forceBlend = false
	SetBottleState(0,0)
	
	WinePic:SetActive(false)
		Bottle:SetActive(true)
	BottleShade:SetActive(true)
end
function SetIsIce(state)
	isIce = state
	BtnIce.transform:GetChild(0).gameObject:SetActive(state)
end
function SetIsAge(state)
	isAge = state
	BtnAge.transform:GetChild(0).gameObject:SetActive(state)
end
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
--状态1 调制 状态2 停止 状态3 上酒
function ChangeBtnFlairState(State)
	local BtnFlairText = BtnFlair:GetComponentInChildren(typeof(CS.ExText))
	local BtnFlairColor = BtnFlair:GetComponent("ExImage")
	local BtnBlendColor = BtnBlend:GetComponent("ExImage")
	local BtnServeColor = Btn_GetWine:GetComponent("ExImage")
	if State == 1  then
		BtnFlairText.text =GetName(230005)
		BtnFlair:SetActive(true)
		BtnBlend:SetActive(showBlendButton)
		Btn_GetWine:SetActive(false)
		Tex_Hint:SetActive(false)
		if(TotalCount >0) then
			BtnFlairColor.color = AlcoholColorBG[7]
			BtnBlendColor.color = AlcoholColorBG[7]
			BtnRemake:GetComponent("ExImage").color = AlcoholColorBG[7]
		else
			BtnFlairColor.color = AlcoholColorBG[8]
			BtnBlendColor.color = AlcoholColorBG[8]
			BtnRemake:GetComponent("ExImage").color = AlcoholColorBG[8]
		end
		
	end
	if State == 2  then
		BtnFlairText.text =GetName(230134)
		BtnFlair:SetActive(true)
		BtnBlend:SetActive(false)
		Btn_GetWine:SetActive(false)
		if forceBlend then
			Tex_Hint:SetActive(false)
		else
			Tex_Hint:SetActive(true)
		end
		BtnFlairColor.color = AlcoholColorBG[7]
	end
	if State == 3 then
		BtnFlair:SetActive(false)
		BtnBlend:SetActive(false)
		Btn_GetWine:SetActive(true)
		Tex_Hint:SetActive(false)
		if(isReadyServe > 0) then
			BtnServeColor.color = AlcoholColorBG[7]
		else
			BtnServeColor.color = AlcoholColorBG[8]
		end
	end
end
function InitLeftPart()
	WelcomePage:SetActive(true)
	WineListNode:SetActive(false)
	WineIntroductionNode:SetActive(false)
	Tex_AVGContent:GetComponent("ExText").text = CS.UnityEngine.PlayerPrefs.GetString('VA11expectLine'," ")

end
function InitRightPart()
	ListSprite = FormulaSelectionNode:GetComponent("UGUISpriteHolder").listSprite
	ListSpriteWinePic = WinePic:GetComponent("UGUISpriteHolder").listSprite
	--初始化数据:加载4个页签一个大页签
	for i = 1,4 do
		local VA11BartendingNormalItemModel = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11BartendingNormalItem"))
		VA11BartendingNormalItemModel.transform:SetParent(NormalGrid.transform,false)
		BartendingListItemList[i] = VA11BartendingNormalItemModel
		--色指定...		
		InitBartendingItem(VA11BartendingNormalItemModel,i)
	end
	local VA11BartendingSpecialItemModel = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11BartendingSpecialItem"))
	VA11BartendingSpecialItemModel.transform:SetParent(SpecialGrid.transform,false)
	BartendingListItemList[5] = VA11BartendingSpecialItemModel
	InitBartendingItem(VA11BartendingSpecialItemModel,5)
end
function SetTopButtons(a,b,c)
	BtnSelectName.transform:GetChild(0).gameObject:SetActive(a)
	BtnSelectFlavor.transform:GetChild(0).gameObject:SetActive(b)
	BtnSelectType.transform:GetChild(0).gameObject:SetActive(c)
end
function InitBartendingItem(BartendingItem,number)
	local icon = BartendingItem.transform:GetChild(1).gameObject:GetComponent("ExImage")
	local name = BartendingItem.transform:GetChild(3).gameObject:GetComponent("ExText")
	
	icon.sprite = ListSprite[number-1]
	name.text =  AlcoholName[number]
	
end
function ChangeBartendingItem(number)
	local BartendingItem = BartendingListItemList[number]
	local BG = BartendingItem.transform:GetChild(0).gameObject:GetComponent("ExImage")
	local mask = BartendingItem.transform:GetChild(5).gameObject
	local TextNumber = BartendingItem.transform:GetChild(4).gameObject:GetComponent("ExText")
	local zero = (AlcoholCount[number] == 0)
	mask:SetActive(zero)
	if zero then
		TextNumber.text = "--"
		TextNumber.color = AlcoholColorNum[0]
		BG.color = AlcoholColorBG[0]
	else
		local str = tostring(AlcoholCount[number])
		if AlcoholCount[number] < 10 then 
			str = '0'..str
		end
		TextNumber.text = str
		TextNumber.color = AlcoholColorNum[number]
		BG.color = AlcoholColorBG[number]
	end
	
end
function ReSetAccel()
	lastshake = 0
	dst_acceleration_x = 0 
	dst_acceleration_y = 0 
	dst_acceleration_z = 0 
	last_dst_acceleration_x = 0 
	last_dst_acceleration_y = 0 
	last_dst_acceleration_z = 0 
end

function SetCurAccel(acceleration)
		dst_acceleration_x = acceleration.x 
		dst_acceleration_y = acceleration.y 
		dst_acceleration_z = acceleration.z 

		local move =
			math.abs(dst_acceleration_x-last_dst_acceleration_x) +math.abs(dst_acceleration_y-last_dst_acceleration_y) +math.abs(dst_acceleration_z-last_dst_acceleration_z) 
		lastshake = lastshake * 0.7 + move * 0.3 ;

		last_dst_acceleration_x = dst_acceleration_x 
		last_dst_acceleration_y = dst_acceleration_y 
		last_dst_acceleration_z = dst_acceleration_z 
end


function GenColor(r,g,b,a)
	if(r<=1 and g<=1 and b<=1 and a<=1) then	
		return CS.UnityEngine.Color(r,g,b,a)
	else
		return CS.UnityEngine.Color(r/255,g/255,b/255,a/255)
	end
end

function regexAlcohol(str)
	-- 配方文本以@开头时不做文本替换
	if string.find(str, "@") == 1 then
		return string.sub(str, 2);
	else
		return (string.gsub((string.gsub(str,"#(.)",replaceStr2)),"%*(.):(.)",replaceStr))
	end
end
function replaceStr(capture1,capture2)
	if(capture2 == 'N' or capture2 == 'n'or capture2 == 'A'or capture2 == 'a') then
		capture2 = GetName(230133)
	else
		capture2 = capture2.." "
	end
	local num1 = tonumber(capture1)
	local finaleStr = "<color="..AlcoholTextColorName[num1]..">"..capture2..AlcoholName[num1].."</color>"
	return finaleStr
	--<color=#fff775>改变的条件有一种，移动到某个据点。</color>
end
function replaceStr2(capture1)
	local num1
	if(capture1 == 'I' or capture1 == 'i') then
		capture1 = GetName(230003)
		num1 = 6
	else 
		if (capture1 == 'A' or capture1 == 'a') then
			capture1 = GetName(230004)
			num1 = 7
		else
			capture1 = GetName(230132)
			num1 = 8
		end
	end
	local finaleStr = "<color="..AlcoholTextColorName[num1]..">"..capture1.."</color>"
	return finaleStr
end
function PlaySFX(FXname)

	if FXname == "invaild_press" then
		CS.CommonAudioController.PlayUI("UI_va_buttonnoclick")
	end
	if FXname == "vaild_press" then
		CS.CommonAudioController.PlayUI("UI_va_jukepick")
	end
	if FXname == "select_type" then
		CS.CommonAudioController.PlayUI("UI_va_jukepick")
	end
	if FXname == "vaild_select" then
		CS.CommonAudioController.PlayUI("UI_va_jukepick")
	end
	if FXname == "invaild_select" then
		CS.CommonAudioController.PlayUI("UI_va_buttonnoclick")
	end
	if FXname == "ice" then
		CS.CommonAudioController.PlayUI("UI_va_iceadd")
	end
	if FXname == "age" then
		CS.CommonAudioController.PlayUI("UI_va_ageadd")
	end
	if FXname == "pour" then
		CS.CommonAudioController.PlayUI("UI_va_addingredient")
	end
	if FXname == "reset" then
		CS.CommonAudioController.PlayUI("UI_va_buttonclick")
	end
	if FXname == "match" then
		CS.CommonAudioController.PlayUI("UI_va_glassserve")
	end
	if FXname == "flair" then
		CS.CommonAudioController.PlayUI("UI_va_mixdone")
	end
end
function PlayBottleEffect(num)
	BottleEff:SetActive(false)
	BottleEff:GetComponent("ExImage").color = AlcoholColorProgress[num]
	BottleEff:SetActive(true)
end
function PlayResultAnim(isSuccess)
	if isSuccess then
		Tex_Result:GetComponent("ExText").text = GetName(230135)
	else
		Tex_Result:GetComponent("ExText").text = GetName(230136)
	end
	Tex_Result:SetActive(false)
	Tex_Result:GetComponent("ExText").color = AlcoholColorProgress[10]
	Tex_Result:SetActive(true)
end
function GetName(NameID)
	return CS.Data.GetLang(NameID)
end
function GetIcon(iconCode)
	for i=0,ListSpriteWinePic.Count-1 do
		if ListSpriteWinePic[i].name == iconCode then
			return ListSpriteWinePic[i]
		end
	end
end
