local util = require 'xlua.util'
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility
local v3 = CS.UnityEngine.Vector3
local v2int = CS.BoardVector
local dir = CS.GF.ExploreDrama.LuaExploreDramaUtility.Direction


Init = function()

	dramaUtil.SetBackgroundDefault();

    local ai = {};
	local a = dramaUtil.GetTeam().Count;
    for i=1,5 do
        if i-1 < a then
			local r_time = math.random(3);
			if i == 5 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(0,15));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);
				dramaUtil.PlanAIMoveTo(ai[i],v2int(23,15),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 7.5,1,"attack");
				dramaUtil.PlanAIStay(ai[i], r_time,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 8-r_time,1,"victory,victoryloop~",true,"Emoji__0502,Emoji__1203,Emoji_1720,Emoji_1740,,,");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(53,15),'move',1.5);				
			elseif i == 2 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(3,18));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(27,18),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 7.5,1,"attack");
				dramaUtil.PlanAIStay(ai[i], r_time,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 8-r_time,1,"victory,victoryloop~",true,"Emoji__0502,Emoji__1203,Emoji_1720,Emoji_1740,,,");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(57,18),'move',1.5);
			elseif i == 1 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(6,21));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(31,21),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 7.5,1,"attack");
				dramaUtil.PlanAIStay(ai[i], r_time,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 8-r_time,1,"victory,victoryloop~",true,"Emoji__0502,Emoji__1203,Emoji_1720,Emoji_1740,,,");	
				dramaUtil.PlanAIMoveTo(ai[i],v2int(57,21),'move',1.5);
			elseif i == 3 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(4,24));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(29,24),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 7.5,1,"attack");
				dramaUtil.PlanAIStay(ai[i], r_time,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 8-r_time,1,"victory,victoryloop~",true,"Emoji__0502,Emoji__1203,Emoji_1720,Emoji_1740,,,");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(57,24),'move',1.5);
			elseif i == 4 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(1,27));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(25,27),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 7.5,1,"attack");	
				dramaUtil.PlanAIStay(ai[i], r_time,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 8-r_time,1,"victory,victoryloop~",true,"Emoji__0502,Emoji__1203,Emoji_1720,Emoji_1740,,,");	
				dramaUtil.PlanAIMoveTo(ai[i],v2int(57,27),'move',1.5);
			end
			ai[i]:StartAI();
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
            aiPets[i] = dramaUtil.CreateAIWithPetId(petData.id,v2int(i*3+math.random(1,5),i*2+6));
            dramaUtil.PlanAIAppear(aiPets[i],0,dramaUtil.Direction.right);
			if dramaUtil.GetPetTagRaw(petData) == '1001' then
				nums = {1,3,5,2,4};
				act_num = nums[math.random(5)];
				pet_speed = 1.2;
			elseif dramaUtil.GetPetTagRaw(petData) == '1002' then
				nums = {1,3,5,2};
				act_num = nums[math.random(3)];
				if petData.spine_code == 'pet_dog2' then
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
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i+math.random(20,24),5+math.random(8,10)),'move',pet_speed);
			dramaUtil.PlanAIStay(aiPets[i], pet_speed*3.5,-1,'wait');
			dramaUtil.PlanAIStay(aiPets[i], pet_speed*4.5,-1,petacts[act_num]);
			dramaUtil.PlanAIMoveTo(aiPets[i],v2int(54,23),'move',pet_speed);
            aiPets[i]:StartAI();
        end
    end
	
	local aienemy = {};
	local enemy = {'Prowler','Scouts','Dinergate','Ripper','Vespid'};
	local die_ways	= {"die,ppppp~","die2,ppppp~","die3,ppppp~"};
	local enemy_team = enemy [math.random(5)]
	enemy = nil;
		for i = 1,5 do
			local die_way =die_ways [math.random(3)]
			if i == 1 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(48,15),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 8.5,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 7.5,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);
			elseif i == 2 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(45,18),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 8.5,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 4.5,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);
			elseif i == 3 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(42,21),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 8.5,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 1.5,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);
			elseif i == 4 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(44,24),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 8.5,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 3,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);
			elseif i == 5 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(47,21),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 8.5,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 6,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);			
			end			
			aienemy[i]:StartAI();
		end
	enemy_team = nil;
	die_way = nil;
    
    dramaUtil.PlanCameraFocus(ai[1].transform,3.5,v3(-0.8,0.5,-3),0);
	dramaUtil.PlanCameraFocus(aienemy[2].transform,2,v3(0,0.5,-3),0);
	dramaUtil.PlanCameraFocus(aienemy[3].transform,12,v3(-2.4,1,-7),0);
	dramaUtil.PlanCameraFocus(ai[1].transform,5,v3(-1,0,0),0);
	dramaUtil.PlanCameraFocus(ai[1].transform,4,v3(-0.8,0.5,-3),0);

    ai = nil;
	aienemy = nil
	a = nil;
	petacts = nil;
    aiPets = nil;
	nums = nil;
	act_num = nil;
	furniture = nil;
	walktime = nil;
	pet_speed = nil;
	idol_speed = nil;	
	die_ways = nil;
end


Final = function()
end
