
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
	local listGun = dramaUtil.GetSortedGunList("62");
    for i=0,listGun.Count-1 do
		ai[i+1] = dramaUtil.CreateAIWithGun(listGun[i],v2int((5-i)*2+math.random(6,10),(3-i)*math.random(2)+math.random(15,20)),false);
		dramaUtil.PlanAIAppear(ai[i+1],0,1);
		if i == 0 then 
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(math.random(21,25),math.random(18,22)),'move',1.2);
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(math.random(26,28),math.random(18,22)),'move',0.9);
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(29,21),'move',0.6);
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(30,21),'move',0.3);
			dramaUtil.PlanAIStay(ai[i+1], 2,1,"wait",true);
			dramaUtil.PlanAIStay(ai[i+1], 8,-2,"lying",true);
			dramaUtil.PlanAIStay(ai[i+1], 4.1,1,"wait",true,"Emoji__5001,Emoji__1401,,");
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(60,21),'move',1.5);
		elseif i <= math.random(2) then
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(i*3+math.random(32,34),i*3+math.random(14,18)),'move',1.2);
			dramaUtil.PlanAIStay(ai[i+1],4.1,0,"wait",true,"Emoji_1753,Emoji__1504,Emoji_1753,Emoji__1504");
			dramaUtil.PlanAIStay(ai[i+1],5,0,"wait",true,"Emoji_1753,Emoji__1504,Emoji_1753,Emoji__1504,Emoji_0201,Emoji_0201");
			dramaUtil.PlanAIStay(ai[i+1], 5,0,"wait",true,"Emoji_1753,Emoji__1504,Emoji_1753,Emoji__1504");
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(60,26),'move',1.5);
		else 
			dramaUtil.PlanAIMoveTo(ai[i+1],v2int(60,21),'move',1.2);
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
			if math.random(2) == 1 then
				dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*3+56,25),'move',pet_speed);
			else 
				dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*2+33,15+math.random(8,10)),'move',pet_speed);
				dramaUtil.PlanAIStay(aiPets[i], pet_speed*6,0,petacts[act_num],true);
				dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*3+56,25),'move',pet_speed);
			end
            aiPets[i]:StartAI();
        end
    end

    dramaUtil.PlanCameraFocus(ai[1].transform,27,v3(0,0,0),0);

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