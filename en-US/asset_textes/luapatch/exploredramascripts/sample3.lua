
local util = require 'xlua.util' 
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility 
local v3 = CS.UnityEngine.Vector3 
local v2int = CS.BoardVector 

Init = function()
    local bg = {'forest','forest2','grasslands'};

    dramaUtil.SetBackground(bg[math.random(3)]);
    bg = nil;

    local ai = {};
    for i=1,5 do
        if i-1 < dramaUtil.GetTeam().Count then
            ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(i+4,i*4+10),false);
            dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);
            dramaUtil.PlanAIMoveTo(ai[i],v2int(i+50,i*4+10),'move',1);
            ai[i]:StartAI();
        end
    end
    
    local aiPets = {};
    for i=1,3 do
        if i-1 < dramaUtil.GetPetInfo().Count then
            aiPets[i] = dramaUtil.CreateAIWithPetId(dramaUtil.GetPetInfo()[i-1].id,v2int(i+1,i*4+30));
            dramaUtil.PlanAIAppear(aiPets[i],0,dramaUtil.Direction.right);
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i+50,i*4+30),'move',1);
            aiPets[i]:StartAI();
        end
    end
    
    dramaUtil.PlanCameraFocus(ai[2].transform,10,v3(0,0,0),0);

    ai = nil;
    aiPets = nil;
end

Final = function()
end