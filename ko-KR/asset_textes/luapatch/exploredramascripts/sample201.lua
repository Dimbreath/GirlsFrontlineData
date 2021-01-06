
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
	local rannum1 = tof[math.random(2)];
	local focus_target = math.random(a);
	local idol_speed = 1.2;
	local times = 1 ;
	local b = 0;
	local photo_time = 12;
    for i=1,5 do
        if i-1 < a then
			if dramaUtil.GetGunHasTag(dramaUtil.GetTeam()[i-1],"62") == true and math.random(12) <= 6 and times == 1 and rannum1 == false then 
				times = 2;
				b = i;
				focus_target = b;
				photo_time = 29;
			end
			if rannum1 == true then
				idol_speed = 2;
			end
			
			if b == 0 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(i*math.random(2,4)+3,i*math.random(2,4)+10),rannum1);
				dramaUtil.PlanAIAppear(ai[i],0,1);
				dramaUtil.PlanAIMoveTo(ai[i],v2int(i+math.random(64,70),i*4+math.random(8,12)),'move',idol_speed);
				dramaUtil.PlanAIStay(ai[i], 10,0,"wait",true);
			else 	
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int((6-i)*2+math.random(6,10),(4-i)*math.random(2)+math.random(15,20)),false);
				dramaUtil.PlanAIAppear(ai[i],0,1);
				if i == b then 
					dramaUtil.PlanAIMoveTo(ai[i],v2int(math.random(21,25),math.random(22,26)),'move',1.2);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(math.random(26,28),math.random(22,26)),'move',0.9);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(29,23),'move',0.6);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(30,23),'move',0.3);
					dramaUtil.PlanAIStay(ai[i], 2,1,"wait",true);
					dramaUtil.PlanAIStay(ai[i], 8,-2,"lying",true);
					dramaUtil.PlanAIStay(ai[i], 4.1,1,"wait",true,"Emoji__5001,Emoji__1401,,");
					dramaUtil.PlanAIMoveTo(ai[i],v2int(60,23),'move',1.5);
				elseif i > math.random(3,4) then
					dramaUtil.PlanAIMoveTo(ai[i],v2int((i-1)*2+math.random(28,30),(i-1)*3+math.random(14,18)),'move',1.2);
					dramaUtil.PlanAIStay(ai[i],4.1,0,"wait",true,"Emoji_1753,Emoji__1504,Emoji_1753,Emoji__1504");
					dramaUtil.PlanAIStay(ai[i],4.5,0,"wait",true,"Emoji_1753,Emoji__1504,Emoji_1753,Emoji__1504,Emoji_0201,Emoji_0201");
					dramaUtil.PlanAIStay(ai[i], 4.5,0,"wait",true,"Emoji_1753,Emoji__1504,Emoji_1753,Emoji__1504");
					dramaUtil.PlanAIMoveTo(ai[i],v2int(60,26),'move',1.5);
				else
					dramaUtil.PlanAIMoveTo(ai[i],v2int(60,21),'move',1.2);
				end
			end
		
            ai[i]:StartAI();
        end
    end
    rannum1 = nil;
	times = nil;
	b = nil;
	
    local aiPets = {};
	local petacts = {"action1","action2","wait","action3","lying","sit"};
	local nums = {};
	local act_num = 1;
	local pet_speed = 1;
	local petData;
    for i=1,3 do
        if i-1 < dramaUtil.GetPetInfo().Count then
			petData= dramaUtil.GetPetInfo()[i-1];
            aiPets[i] = dramaUtil.CreateAIWithPetId(petData.id,v2int(i*3+math.random(8,12),i*2+25));
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
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*2+math.random(70,78),25+math.random(8,10)),'move',pet_speed);
			dramaUtil.PlanAIStay(aiPets[i], 10,-1,petacts[act_num]);
            aiPets[i]:StartAI();
        end
    end

    dramaUtil.PlanCameraFocus(ai[focus_target].transform,photo_time,v3(4-focus_target,0,0),0);

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
	photo_time = nil;
end


Final = function()
end