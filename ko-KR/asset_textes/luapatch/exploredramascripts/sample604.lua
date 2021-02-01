local util = require 'xlua.util'
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility
local v3 = CS.UnityEngine.Vector3
local v2int = CS.BoardVector
local dir = CS.GF.ExploreDrama.LuaExploreDramaUtility.Direction


Init = function()

	dramaUtil.SetBackgroundDefault();

    local ai = {};
	local a = dramaUtil.GetTeam().Count;
	local rand_num;
    for i=1,5 do
        if i-1 < a then
			if i == 5 then
				rand_num = math.random(0,2);
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(3,15));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);
				dramaUtil.PlanAIMoveTo(ai[i],v2int(20,15),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 1.3,1,"attack");
				dramaUtil.PlanAIStay(ai[i], rand_num,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 10,1,"victory,victoryloop~",true,"Emoji_1732,Emoji__1001,Emoji_1744,Emoji_1722,,");	
				dramaUtil.PlanAIStay(ai[i], 2-rand_num,1,"wait");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(50,15),'move',1.5);
			elseif i == 2 then
				rand_num = math.random(0,2);
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(6,18));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(23,18),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 1.3,1,"attack");
				dramaUtil.PlanAIStay(ai[i], rand_num,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 10,1,"victory,victoryloop~",true,"Emoji_1732,Emoji__1001,Emoji_1744,Emoji_1722,,");	
				dramaUtil.PlanAIStay(ai[i], 2-rand_num,1,"wait");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(53,18),'move',1.5);
			elseif i == 1 then
				rand_num = math.random(0,2);
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(9,21));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(26,21),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 1.3,1,"attack");
				dramaUtil.PlanAIStay(ai[i], rand_num,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 10,1,"victory,victoryloop~",true,"Emoji_1732,Emoji__1001,Emoji_1744,Emoji_1722,,");
				dramaUtil.PlanAIStay(ai[i], 2-rand_num,1,"wait");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(53,21),'move',1.5);
			elseif i == 3 then
				rand_num = math.random(0,2);
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(7,24));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(24,24),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 1.3,1,"attack");
				dramaUtil.PlanAIStay(ai[i], rand_num,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 10,1,"victory,victoryloop~",true,"Emoji_1732,Emoji__1001,Emoji_1744,Emoji_1722,,");
				dramaUtil.PlanAIStay(ai[i], 2-rand_num,1,"wait");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(53,24),'move',1.5);
			elseif i == 4 then
				rand_num = math.random(0,2);
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(4,27));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(21,27),'move',1.5);
				dramaUtil.PlanAIStay(ai[i], 1.3,1,"attack");	
				dramaUtil.PlanAIStay(ai[i], rand_num,1,"wait");
				dramaUtil.PlanAIStay(ai[i], 10,1,"victory,victoryloop~",true,"Emoji_1732,Emoji__1001,Emoji_1744,Emoji_1722,,");
				dramaUtil.PlanAIStay(ai[i], 2-rand_num,1,"wait");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(51,27),'move',1.5);
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
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*2 + 22,5+math.random(8,10)),'move',pet_speed);--math.random(28,32)
			dramaUtil.PlanAIStay(aiPets[i], 2.5*pet_speed,-1,'wait');
			dramaUtil.PlanAIStay(aiPets[i], 2.8*pet_speed,-1,petacts[act_num]);
			dramaUtil.PlanAIMoveTo(aiPets[i],v2int(51,15),'move',pet_speed);
            aiPets[i]:StartAI();
        end
    end
	
	local aienemy = {};
	local enemy_boss = {'Weaver','Scarecrow','Excutioner','BossGager','Hunter','BossArchitect','Intruder','Dreamer','Destroyer','Alchemist','Justice'};
	local enemy = {'Manticore','Jaeger_SWAP','Guard_SWAP','Dragoon_SWAP','Prowler_SWAP','Aegis_SWAP','Striker_SWAP'};
	local die_ways	= {"die,ppppp~","die2,ppppp~","die3,ppppp~"};
	local enemy_team = enemy [math.random(6)];
	local boss = enemy_boss[math.random(11)];
	enemy = nil;
		for i = 1,6 do
			local die_way =die_ways [math.random(3)]
			if enemy_team == 'Manticore' then
				die_way = "die,ppppp~";
			end
			if i == 1 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(45,15),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 6.3,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 1.2,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);
			elseif i == 2 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(42,18),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 6.3,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 1.2,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);
			elseif i == 3 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(39,21),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 6.3,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 1.2,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);
			elseif i == 4 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(41,24),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 6.3,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 1.2,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);
			elseif i == 5 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(44,21),true,1);
				dramaUtil.PlanAIStay(aienemy[i], 6.3,0,"wait");
				dramaUtil.PlanAIStay(aienemy[i], 1.2,0,"attack");
				dramaUtil.PlanAIDisappear(aienemy[i],1,-1,die_way);			
			elseif i == 6 then
				aienemy[i]=dramaUtil.CreateAIWithCode(boss, v2int(42,14),true,1);	
				dramaUtil.PlanAIStay(aienemy[i], 15,0,"wait",true,"|3,|2,Emoji_1732|1,|2,Emoji_1722|2,Emoji_1704|1,|2,Emoji__0510|2,Emoji__0511");--
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(72,10),'move',2);			
			end	
			aienemy[i]:StartAI();
		end
	enemy_team = nil;
	die_way = nil;

    dramaUtil.PlanCameraFocus(ai[1].transform,3.5,v3(-0.8,0.5,-3),0);
	dramaUtil.PlanCameraFocus(aienemy[2].transform,2,v3(0,0.5,-3),0);
	dramaUtil.PlanCameraFocus(aienemy[3].transform,12,v3(-2.4,1,-7),0);
	dramaUtil.PlanCameraFocus(ai[1].transform,5,v3(-1,0,0),0);
	
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
	enemy_boss = nil;
	rand_num = nil;
end


Final = function()
end
