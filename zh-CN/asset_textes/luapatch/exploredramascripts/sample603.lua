
local util = require 'xlua.util'
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility
local v3 = CS.UnityEngine.Vector3
local v2int = CS.BoardVector
local dir = CS.GF.ExploreDrama.LuaExploreDramaUtility.Direction


Init = function()

	dramaUtil.SetBackgroundDefault();	
	local aienemy = {};
	local enemy = {'Golyat','GolyatPlus','Prowler_SWAP','Aegis_SWAP','Jaeger_SWAP','Guard_SWAP','Dragoon_SWAP'};--
	local enemy_team = enemy [math.random(7)];
	local enemy_speed = 1;
	local change_speed = 0.2;
	if enemy_team == 'Golyat' or enemy_team == 'GolyatPlus' then
		enemy_speed = 1.2;
		change_speed = 0.5;
	end
	enemy = nil;
		for i = 1,5 do
			if i == 1 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(119,15),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(89,15),'move',enemy_speed);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(0,15),'move',enemy_speed+change_speed);
			elseif i == 2 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team,v2int(116,18),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(86,18),'move',enemy_speed);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(0,18),'move',enemy_speed+change_speed);
			elseif i == 3 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(113,21),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(83,21),'move',enemy_speed);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(80,21),'move',enemy_speed+change_speed);
				if enemy_team == 'Golyat' then
					dramaUtil.PlanAIDisappear(aienemy[i],1,-1,'die,ppppp~');
				else			
					dramaUtil.PlanAIMoveTo(aienemy[i],v2int(0,21),'move',enemy_speed+change_speed);
				end
			elseif i == 4 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(115,24),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(85,24),'move',enemy_speed);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(76,24),'move',enemy_speed+change_speed);
				if enemy_team == 'Golyat' then
					dramaUtil.PlanAIDisappear(aienemy[i],1,-1,'die,ppppp~');
				else			
					dramaUtil.PlanAIMoveTo(aienemy[i],v2int(0,24),'move',enemy_speed+change_speed);
				end
			elseif i == 5 then
				aienemy[i]=dramaUtil.CreateAIWithCode(enemy_team, v2int(116,20),true,1);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(86,27),'move',enemy_speed);
				dramaUtil.PlanAIMoveTo(aienemy[i],v2int(0,27),'move',enemy_speed+change_speed);				
			end		
			aienemy[i]:StartAI();
		end
	
    local ai = {};
	local a = dramaUtil.GetTeam().Count;
	local tof = {false,true};
	local attack_time = 5.5;
	if enemy_team == 'GolyatPlus' then
		attack_time = 3;
	elseif 	enemy_team == 'Golyat' then
		attack_time = 4;
	end
    for i=1,5 do
        if i-1 < a then
			local wait_time = 4.5;
			local idol_speed = 1.2;
			local rannum1 = tof[math.random(2)];
			if rannum1 == true then
				idol_speed = 1.7;
				wait_time = 5.5;
			end
			if enemy_team == 'GolyatPlus' then
				wait_time = wait_time - 1.4;
			end
			if i == 5 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(40,15),false);
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);
				dramaUtil.PlanAIMoveTo(ai[i],v2int(59+math.random(4,6),15),'move',1.2);
				dramaUtil.PlanAIStay(ai[i], 4.1,1,"wait",true,"|1,Emoji_1726|2,Emoji_1706|1,Emoji_9013");
				dramaUtil.PlanAIMoveTo(ai[i],v2int(0,15),'move',1.2+change_speed-0.1);	
			elseif i == 2 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(43,18),rannum1);
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(63+math.random(2,4),18),'move',idol_speed);
				dramaUtil.PlanAIStay(ai[i], wait_time,1,"wait",true,"Emoji_1706,Emoji_1733,Emoji_1726,Emoji_1704,,");
				if rannum1 == true then
					dramaUtil.PlanAIStay(ai[i], attack_time,1,"attack",true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(0,18),'move',idol_speed+change_speed);
				else
					dramaUtil.PlanAIMoveTo(ai[i],v2int(0,18),'move',idol_speed+change_speed);
				end
			elseif i == 1 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(46,21));
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(68,21),'move',1.7);
				dramaUtil.PlanAIStay(ai[i], 5.5,1,"wait",true,"Emoji_1706,Emoji_1733,Emoji_1726,Emoji_1704,");
				dramaUtil.PlanAIStay(ai[i], attack_time,1,"attack",true);
				dramaUtil.PlanAIMoveTo(ai[i],v2int(0,21),'move',1.7+change_speed);				
			elseif i == 3 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(44,24),rannum1);
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(65+math.random(2,3),24),'move',idol_speed);
				dramaUtil.PlanAIStay(ai[i], wait_time,1,"wait",true,"Emoji_1706,Emoji_1733,Emoji_1726,Emoji_1704,,");
				if rannum1 == true then
					dramaUtil.PlanAIStay(ai[i], attack_time,1,"attack",true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(0,24),'move',idol_speed+change_speed);
				else
					dramaUtil.PlanAIMoveTo(ai[i],v2int(0,24),'move',idol_speed+change_speed);
				end				
			elseif i == 4 then
				ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(41,27),rannum1);
				dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);				
				dramaUtil.PlanAIMoveTo(ai[i],v2int(61+math.random(3,5),27),'move',idol_speed);
				dramaUtil.PlanAIStay(ai[i], wait_time,1,"wait",true,"Emoji_1706,Emoji_1733,Emoji_1726,Emoji_1704,,");	
				if rannum1 == true then
					dramaUtil.PlanAIStay(ai[i], attack_time,1,"attack",true);
					dramaUtil.PlanAIMoveTo(ai[i],v2int(0,24),'move',idol_speed+change_speed);
				else
					dramaUtil.PlanAIMoveTo(ai[i],v2int(0,24),'move',idol_speed+change_speed);
				end						
			end
			ai[i]:StartAI();
			wait_time = nil;
			idol_speed = nil;
			rannum1 = nil;
		end
    end	
    tof = nil;
	
    local aiPets = {};
	local petData;
	local min_speed = 1.5;
	local focus_target = ai[1];
    for i=1,3 do
        if i-1 < dramaUtil.GetPetInfo().Count then
			local pet_speed = 1;
			petData= dramaUtil.GetPetInfo()[i-1];
            aiPets[i] = dramaUtil.CreateAIWithPetId(petData.id,v2int(i*3+math.random(30,35),i*2+6));
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
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i*2+math.random(44,47)+math.floor(9*pet_speed),10),'move',pet_speed);
			dramaUtil.PlanAIStay(aiPets[i], 3*pet_speed,-1,'wait');
			dramaUtil.PlanAIMoveTo(aiPets[i],v2int(0,27),'move',pet_speed +change_speed);
            aiPets[i]:StartAI();
			if pet_speed < min_speed then
				min_speed = pet_speed;
				focus_target = aiPets[i];
			end
        end
    end
 
    dramaUtil.PlanCameraFocus(ai[1].transform,10,v3(-0.2,0,0),0);
	dramaUtil.PlanCameraFocus(ai[1].transform,8,v3(2.5,0.5,-3),0);
	if focus_target == ai[1] then
		dramaUtil.PlanCameraFocus(focus_target.transform,4,v3(0,1,-8),0);
	else
		dramaUtil.PlanCameraFocus(focus_target.transform,4,v3(0,1,-8),0);
	end

    ai = nil;
	aienemy = nil
	a = nil;
    aiPets = nil;
	furniture = nil;
	pet_speed = nil;
	focus_target =	nil;
	min_speed = nil;
	enemy_speed = nil; 
	change_speed = nil;
	enemy_team = nil;	
	attack_time = nil;
end


Final = function()
end
