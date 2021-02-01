
local util = require 'xlua.util'
local dramaUtil = CS.GF.ExploreDrama.LuaExploreDramaUtility
local v3 = CS.UnityEngine.Vector3
local v2int = CS.BoardVector


Init = function()

    dramaUtil.SetBackground('snowvillage');

    local ai1 = dramaUtil.CreateAIWithGunId(1,v2int(0,0));
    dramaUtil.PlanAIAppear(ai1,5,dramaUtil.Direction.left);
    dramaUtil.PlanAIMoveTo(ai1,v2int(100,2),'move',15);
    dramaUtil.PlanAIMoveFromTo(ai1,v2int(100,20),v2int(0,20),'move',15);
    dramaUtil.PlanAIStay(ai1,9999,dramaUtil.Direction.left,'victory,victoryloop~');
    ai1:StartAI();

    local ai2 = dramaUtil.CreateAIWithCode('Dinergate',v2int(10,3),true);
    dramaUtil.PlanAIAppear(ai2,3,dramaUtil.Direction.right);
    dramaUtil.PlanAIMoveTo(ai2,v2int(20,10),'move',2);
    ai2:StartAI();

    local ai3 = dramaUtil.CreateAIWithGun(dramaUtil.GetTeam()[0],v2int(8,8),false);
    dramaUtil.PlanAIAppear(ai3,1,dramaUtil.Direction.right);
    dramaUtil.PlanAIMoveTo(ai3,v2int(40,8));
    --dramaUtil.PlanAIStay(ai3,9999,dramaUtil.Direction.random,'attack');
    ai3:StartAI();

    
    dramaUtil.SetCameraPosition(v3(-21,3.03,-30));
    dramaUtil.PlanCameraMoveBy(3,v3(3,0,0),0);
    dramaUtil.PlanCameraFocus(ai3.transform,10,v3(0,0,0),0);

    dramaUtil.PlanCameraMoveBy(5,v3(-1,0,0),0);

    ai1 = nil;
    ai2 = nil;
    ai3 = nil;
end

Final = function()
end