
local util = require 'xlua.util'
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility
local v3 = CS.UnityEngine.Vector3
local v2int = CS.BoardVector
local dir = CS.GF.ExploreDrama.LuaExploreDramaUtility.Direction


Init = function()

	dramaUtil.SetBackgroundDefault();

    local ai = {};
	local a = dramaUtil.GetTeam().Count;
	local tof = {false,true};	
    for i=1,5 do
        if i-1 < a then
			local rannum1 = tof[math.random(2)]	
			local idol_speed = 1.5;
			local wait_time = 4.5;
			if rannum1 == true then
				idol_speed = 2;
				wait_time = 6.5;
			end
			if i == 5 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(0,15),rannum1);
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);
				dramaUtil.PlanAIMoveTo(ai[i],v2int(19+math.random(4,6),15),'move',idol_speed);
				dramaUtil.PlanAIStay(ai[i], wait_time,1,"wait",true,"Emoji_1721,Emoji__1303,Emoji__1002,Emoji_0204,,,,");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(80,15),'move',1);		
			elseif i == 2 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(3,18),rannum1);
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(23+math.random(3,5),18),'move',idol_speed);
				dramaUtil.PlanAIStay(ai[i], wait_time,1,"wait",true,"Emoji_1721,Emoji__1303,Emoji__1002,Emoji_0204,,,,");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(80,18),'move',1);				
			elseif i == 1 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(6,21));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(28,21),'move',2);
				dramaUtil.PlanAIStay(ai[i], 6.5,1,"wait",true,"Emoji_1721,Emoji__1303,Emoji__1002,Emoji_0204,,");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(80,21),'move',1);				
			elseif i == 3 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(4,24),rannum1);
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(25+math.random(3,5),24),'move',idol_speed);
				dramaUtil.PlanAIStay(ai[i], wait_time,1,"wait",true,"Emoji_1721,Emoji__1303,Emoji__1002,Emoji_0204,,,,");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(80,24),'move',1);	
			elseif i == 4 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(1,27),rannum1);
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(21+math.random(4,6),27),'move',idol_speed);
				dramaUtil.PlanAIStay(ai[i], wait_time,1,"wait",true,"Emoji_1721,Emoji__1303,Emoji__1002,Emoji_0204,,,,");	
				dramaUtil.PlanAIMoveTo(ai[i],v2int(80,27),'move',1);								
			end
			ai[i]:StartAI();
        end
	wait_time = nil;
	idol_speed = nil;		
	rannum1 = nil;
    end	
    tof = nil;

	
    local aiPets = {};
	local pet_speed = 1;
	local petData;
	local max_speed = 1.5;
	local focus_target = ai[1];
    for i=1,3 do
        if i-1 < dramaUtil.GetPetInfo().Count then
			petData= dramaUtil.GetPetInfo()[i-1];
            aiPets[i] = dramaUtil.CreateAIWithPetId(petData.id,v2int(i*3+math.random(1,5),i*2+6));
            dramaUtil.PlanAIAppear(aiPets[i],0,dramaUtil.Direction.right);
			if dramaUtil.GetPetTagRaw(petData) == '1001' then
				pet_speed = 1.2;
			elseif dramaUtil.GetPetTagRaw(petData) == '1002' then
				pet_speed = 1.2;
				if petData.spine_code == 'pet_sp4' then
					pet_speed = 0.96;
				end
			elseif dramaUtil.GetPetTagRaw(petData) == '1003' then
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
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*2+math.random(18,22),5+math.random(8,10)),'move',pet_speed);
			dramaUtil.PlanAIStay(aiPets[i], 2.5*pet_speed,-1,'wait');
			dramaUtil.PlanAIMoveTo(aiPets[i],v2int(80,27),'move',pet_speed);
            aiPets[i]:StartAI();
			if pet_speed > max_speed then
				max_speed = pet_speed;
				focus_target = aiPets[i];
			end
        end
    end
	
	local aienemy = {};
	local enemy = {'Manticore','Strelet','Rodelero','Doppelsoldner','Jaeger_SWAP','Guard_SWAP','Dragoon_SWAP','Uhlan'};
	local enemy_team = enemy [math.random(8)]
	enemy = nil;
		for i = 1,5 do
			if i == 1 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(39,15),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(100,15),'move',1.2);
			elseif i == 2 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team,v2int(36,18),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(100,18),'move',1.2);
			elseif i == 3 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(33,21),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(100,21),'move',1.2);
			elseif i == 4 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(35,24),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(100,24),'move',1.2);
			elseif i == 5 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(38,21),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(100,21),'move',1.2);				
			end
			aienemy[i]:StartAI();			
		end
	enemy_team = nil;
    
    dramaUtil.PlanCameraFocus(ai[1].transform,6.5,v3(-0.2,0,0),0);
	dramaUtil.PlanCameraFocus(ai[1].transform,10.5,v3(3,1,-8),0);
	if focus_target == ai[1] then
		dramaUtil.PlanCameraFocus(focus_target.transform,4,v3(2.5,1,-8),0);
	else
		dramaUtil.PlanCameraFocus(focus_target.transform,4,v3(0,1,-8),0);
	end

    ai = nil;
	aienemy = nil
	a = nil;
    aiPets = nil;
	furniture = nil;
	walktime = nil;
	pet_speed = nil;
	idol_speed = nil;
	focus_target =	nil;
	max_speed = nil;
end


Final = function()
end