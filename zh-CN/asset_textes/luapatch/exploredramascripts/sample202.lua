
local util = require 'xlua.util' 
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility 
local v3 = CS.UnityEngine.Vector3
local v2int = CS.BoardVector
local dir = CS.GF.ExploreDrama.LuaExploreDramaUtility.Direction


Init = function()
   
	dramaUtil.SetBackgroundDefault();

    local ai = {};
	local tof = {false,true};
	local a = dramaUtil.GetTeam().Count;	
	local focus_target = math.random(a);
	local rannum1;
    for i=1,5 do
        if i-1 < dramaUtil.GetTeam().Count then
			local idol_speed = 1.2;
			rannum1 = tof[math.random(2)]	
			if rannum1 == true then
				idol_speed = 2
			end
			ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(i*math.random(2,4)+3,i*math.random(2,4)+10),rannum1);

            dramaUtil.PlanAIAppear(ai[i],0,1);

            dramaUtil.PlanAIMoveTo(ai[i],v2int(i+math.random(68,74),i*4+math.random(8,12)),'move',idol_speed);
			dramaUtil.PlanAIStay(ai[i], 10,0,"wait",true);
            ai[i]:StartAI();
			rannum1 = nil;
        end
    end
    
    local aiPets = {};
	local petacts = {"action1","action2","wait","action3","lying","sit"};
	local nums = {};
	local act_num = 1;
	local pet_speed = 1;
	local petData;
    for i=1,3 do
        if i-1 < dramaUtil.GetPetInfo().Count then
			petData= dramaUtil.GetPetInfo()[i-1];
            aiPets[i] = dramaUtil.CreateAIWithPetId(petData.id,v2int(i*3+math.random(8,12),i*2+15));
            dramaUtil.PlanAIAppear(aiPets[i],0,dramaUtil.Direction.right);
			if dramaUtil.GetPetTagRaw(petData) == '1001' then
				nums = {1,3,5,2,4};
				act_num = nums[math.random(5)];
				pet_speed = 1.2;
			elseif dramaUtil.GetPetTagRaw(petData) == '1002' then
				nums = {1,3,5,2,4};
				act_num = nums[math.random(4)];
				if petData.spine_code == 'pet_dogdrive' then
					act_num = nums[math.random(3)];
				elseif petData.spine_code == 'pet_dog4' then
					act_num = nums[math.random(5)];
				end
				pet_speed = 1.2;
				if petData.spine_code == 'pet_sp4' then
					pet_speed = 0.96;
				end
			elseif dramaUtil.GetPetTagRaw(petData) == '1003' then
				nums = {3,6};
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
				nums = {1,2,3,5};
				act_num = nums[math.random(4)];
				pet_speed = 1.2;
				if petData.spine_code == 'pet_sp3' then
					pet_speed = 0.9;
				elseif petData.spine_code == 'pet_sp1' then
					pet_speed = 0.4;
				end
			end
			petData = nil;
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*2+math.random(74,78),15+math.random(8,10)),'move',pet_speed);
			dramaUtil.PlanAIStay(aiPets[i], 10,-1,petacts[act_num]);
            aiPets[i]:StartAI();
        end
    end

    dramaUtil.PlanCameraFocus(ai[focus_target].transform,10,v3(4-focus_target,0,0),0);

	a = nil;
    ai = nil;
	petacts = nil;
    aiPets = nil;
	nums = nil;
	act_num = nil;
	furniture = nil;
	pet_speed = nil;
	idol_speed = nil;
	focus_target = nil;
	tof = nil;
end