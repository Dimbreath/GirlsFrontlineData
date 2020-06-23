
local util = require 'xlua.util' 
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility 
local v3 = CS.UnityEngine.Vector3
local v2int = CS.BoardVector
local dir = CS.GF.ExploreDrama.LuaExploreDramaUtility.Direction


Init = function()
   
	dramaUtil.SetBackgroundDefault();


    local ai = {};
	local a = dramaUtil.GetTeam().Count;
	local focus_target = math.random(a);
	local listGun = dramaUtil.GetSortedGunList("65","51");
    for i=0,listGun.Count-1 do
		if i == 0 then
			ai[i+1] = dramaUtil.CreateAIWithGun(listGun[i],v2int(23,21),false);
		else
			ai[i+1] = dramaUtil.CreateAIWithGun(listGun[i],v2int((5-i)*3+math.random(4,8),(3-i)*math.random(3)+15),false);
		end
		dramaUtil.PlanAIAppear(ai[i+1],0,1);
		if i == 0 then 
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(38,21),'move',1.5);
			dramaUtil.PlanAIStay(ai[i+1], 12,0,"wait",true,"Emoji_90081,Emoji_90081,Emoji_90081,Emoji_90081,Emoji_90081");
			dramaUtil.PlanAIStay(ai[i+1], 1,1,"wait",true);
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(68,22),'move',1.2);
		else
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int((3-i)*2+math.random(29,31),math.random(17,26)),'move',1);
			dramaUtil.PlanAIStay(ai[i+1], 10,-1,"wait",true,"Emoji_1701,Emoji_1714,Emoji_0303,Emoji__0502,,,");
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(68,26),'move',1.5);
		end
			
		ai[i+1]:StartAI();
    end
	
    local aiPets = {};
	local petacts = {"action1","action2","wait","action3","lying","sit"};
	local nums = {};
	local act_num = 5;
	local pet_speed = 1;
	local petData;
    for i=1,3 do
        if i-1 < dramaUtil.GetPetInfo().Count then
			petData= dramaUtil.GetPetInfo()[i-1];
            aiPets[i] = dramaUtil.CreateAIWithPetId(petData.id,v2int(i*2+math.random(2,6),i*2+10));
            dramaUtil.PlanAIAppear(aiPets[i],0,dramaUtil.Direction.right);
			if petData.spine_code == 'pet_sp4' then
				pet_speed = 0.96;
			end
			if dramaUtil.GetPetTagRaw(petData) == '1003' then
				nums = {3,3};
				act_num = nums[math.random(2)];
				pet_speed = 2;
				if petData.spine_code == ('bird_V' or 'pet_bird2') then
					pet_speed = 1.92;
				elseif petData.spine_code == ('pet_bird4' or 'pet_bird3')  then
					pet_speed = 1.68;
				elseif petData.spine_code == 'pet_bird5' then
					pet_speed = 2.16;
				elseif petData.spine_code == 'pet_bird1' then
					pet_speed = 2.76;					
				end				
			elseif dramaUtil.GetPetTagRaw(petData) == '1004' then
				pet_speed = 1.2;
				if petData.spine_code == 'pet_sp3' then
					pet_speed = 0.9;
				elseif petData.spine_code == 'pet_sp1' then
					pet_speed = 0.4;
				end
			end
			petData = nil;
				dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*2+math.random(27,30),i*3+15+math.random(8,10)),'move',pet_speed);
				dramaUtil.PlanAIStay(aiPets[i], pet_speed*6,-1,petacts[act_num],true);
				dramaUtil.PlanAIMoveTo(aiPets[i],v2int(68,26),'move',pet_speed);
            aiPets[i]:StartAI();
        end
    end

    dramaUtil.PlanCameraFocus(ai[1].transform,5.3,v3(0,0,0),0);
	dramaUtil.PlanCameraFocus(ai[1].transform,13,v3(-1.5,0,0),0);
	dramaUtil.PlanCameraFocus(ai[1].transform,3,v3(0,0,0),0);

	a = nil;
    ai = nil;
	petacts = nil;
    aiPets = nil;
	nums = nil;
	act_num = nil;
	furniture = nil;
	pet_speed = nil;
end


Final = function()
end