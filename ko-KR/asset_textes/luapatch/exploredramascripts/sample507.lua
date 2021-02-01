local util = require 'xlua.util' 
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility 
local v3 = CS.UnityEngine.Vector3 
local v2int = CS.BoardVector 
local dir = CS.GF.ExploreDrama.LuaExploreDramaUtility.Direction 

Init = function()

    dramaUtil.SetBackgroundDefault();

    local ai = {};
	local a = dramaUtil.GetTeam().Count;
	local furniture = dramaUtil.CreateFurnitureWithFurnitureId(50007, v2int(39,40));
	local walktime = 10.8;
	local b;
    for i=1,5 do 
        if i-1 < a then
			local idol_speed = 1.2;
			if i >= a-math.random(0,2) then
			  b = true;
			  idol_speed = 2;
			else
			  b = false;
			end

			if i == 1 then
			   ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(12,15),b);  
			else
			   ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(i*3+math.random(8,12),i*2+15),b);
			end
			
			b = nil

            dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);

			if i ~= a then
				if i == 1 then
					dramaUtil.PlanAIMoveTo(ai[i],v2int(35,30),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i],idol_speed*6,-1,"wait",true,"Emoji_1717,Emoji_1718,Emoji_1722,Emoji__1101,,,",true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(65,30),'move',idol_speed);
					if idol_speed == 2 then
						walktime = 6.5;
					end
				elseif i == 2 then
					dramaUtil.PlanAIMoveTo(ai[i],v2int(32,30),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i], idol_speed*6,1,"wait", true,"Emoji_1717,Emoji_1718,Emoji_1722,Emoji__1101,,,",true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(65,30),'move',idol_speed);
				elseif i == 3 then
					dramaUtil.PlanAIMoveTo(ai[i],v2int(42,30),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i], idol_speed*6,0,"wait", true,"Emoji_1717,Emoji_1718,Emoji_1722,Emoji__1101,,,",true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(65,30),'move',idol_speed);
				elseif i == 4 then
					dramaUtil.PlanAIMoveTo(ai[i],v2int(45,30),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i], idol_speed*6,0,"wait", true,"Emoji_1717,Emoji_1718,Emoji_1722,Emoji__1101,,,",true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(65,30),'move',idol_speed);
				end
			end

			if i == a then
			    if a ~= 1 then
					dramaUtil.PlanAIMoveTo(ai[i],v2int(48-i*math.random(1,2),34),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i], 2.5,-2,"wait", true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(25+i*math.random(1,2),30),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i], 2.5,-2,"wait", true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(38,30),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i], idol_speed*2.1,-2,"wait", true,"Emoji_1717,Emoji_1718,Emoji_1722,Emoji__1101,,,");
					dramaUtil.PlanAIMoveTo(ai[i],v2int(65,30),'move',idol_speed);
			    else 
					dramaUtil.PlanAIMoveTo(ai[i],v2int(46-math.random(1,4),34),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i], 2.5,-1,"wait", true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(38,30),'move',idol_speed);
					dramaUtil.PlanAIStay(ai[i], idol_speed*2.1,-1,"wait", true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(65,30),'move',idol_speed);
					walktime = 6.5;
			    end
			end
			ai[i]:StartAI();
			idol_speed = nil;
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
            aiPets[i] = dramaUtil.CreateAIWithPetId(petData.id,v2int(i*3+math.random(8,12),i*2+6));
            dramaUtil.PlanAIAppear(aiPets[i],0,dramaUtil.Direction.right);
			if dramaUtil.GetPetTagRaw(petData) == '1001' then
				nums = {1,3,5,2,4};
				act_num = nums[math.random(5)];
				pet_speed = 1.2;
			elseif dramaUtil.GetPetTagRaw(petData) == '1002' then
				nums = {1,3,5,4,2};
				act_num = nums[math.random(3)];
				if petData.spine_code == 'pet_dog4' then
					act_num = nums[math.random(4)];
				elseif petData.spine_code == 'pet_dog2' then
					nums = {1,3,5,2};
					act_num = nums[math.random(4)];
				end
				pet_speed = 1.2;
				if petData.spine_code == 'pet_sp4' then
					pet_speed = 0.96;
				end
			elseif dramaUtil.GetPetTagRaw(petData) == '1003' then
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
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*3+math.random(30,34),15+math.random(8,10)),'move',pet_speed);
			dramaUtil.PlanAIStay(aiPets[i], pet_speed*5,-1,petacts[act_num],true);
			dramaUtil.PlanAIMoveTo(aiPets[i],v2int(65,30),'move',pet_speed);
            aiPets[i]:StartAI();
        end
    end

    dramaUtil.PlanCameraFocus(ai[1].transform,walktime,v3(3.3,0,-1),0);
	dramaUtil.PlanCameraFocus(furniture.transform,(20.5-walktime),v3(0,0,-1),0.1);
	dramaUtil.PlanCameraMoveBy(2.5, v3(35,0,0),0.05);

	a = nil;
    ai = nil;
	petacts = nil;
    aiPets = nil;
	nums = nil;
	act_num = nil;
	furniture = nil;
	walktime = nil;
	pet_speed = nil;
end

Final = function()
end
