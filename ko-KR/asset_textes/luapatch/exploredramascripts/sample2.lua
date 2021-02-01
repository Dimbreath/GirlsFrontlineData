
local util = require 'xlua.util'
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility 
local v3 = CS.UnityEngine.Vector3 
local v2int = CS.BoardVector 
local dir = CS.GF.ExploreDrama.LuaExploreDramaUtility.Direction 

local test1 = function()
    print('test1');
end


Init = function()
    local bg = {'forest','forest2','grasslands'};
    dramaUtil.SetBackground('bridge');
    bg = nil;

    local ai = {};
    local state;
    for i=1,5 do
        if i-1 < dramaUtil.GetTeam().Count then
            ai[i] = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[i-1],v2int(i+4,i*4+10),true);

            dramaUtil.PlanAIAppear(ai[i],0,dramaUtil.Direction.right);

            dramaUtil.PlanAIMoveTo(ai[i],v2int(i+10,i*4+10),'move',1.7,true);
            state = dramaUtil.PlanAIStay(ai[i],200,-1,"wait",true,"Emoji_0101,Emoji_0102,Emoji_0201");
            state.onEnd = state.onEnd + test1; 
            dramaUtil.PlanAIMoveTo(ai[i],v2int(i+120,i*4+10),'move',1.7,true);
            dramaUtil.PlanAIStay(ai[i],5.0,-1);

            ai[i]:StartAI();
        end
    end
    local test = dramaUtil.CreateAIWithCode("Dinergate", v2int(8, 1), true, 2);
    dramaUtil.PlanAIAppear(test,0,dramaUtil.Direction.right);
    dramaUtil.PlanAIMoveTo(test,v2int(20, 1),'move',1.7,true);
    dramaUtil.PlanAIDisappear(test, 5, -1, "die2,ppppp~");
    test:StartAI();
    test = nil;
    
    local aiPets = {};
    for i=1,3 do
        if i-1 < dramaUtil.GetPetInfo().Count then

            aiPets[i] = dramaUtil.CreateAIWithPetId(dramaUtil.GetPetInfo()[i-1].id,v2int(i+1,i*4+30));
            dramaUtil.PlanAIAppear(aiPets[i],0,dramaUtil.Direction.right);
            dramaUtil.PlanAIMoveTo(aiPets[i],v2int(i+50,i*4+30),'move',1.7);
            aiPets[i]:StartAI();
        end
    end

    dramaUtil.PlanCameraFocus(ai[1].transform,10,v3(2,0,0),0);

    sorted = nil;
    ai = nil;
    aiPets = nil;
end


Final = function()
end
