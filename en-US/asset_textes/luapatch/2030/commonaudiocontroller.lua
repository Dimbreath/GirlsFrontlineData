local util = require 'xlua.util'
xlua.private_accessible(CS.CommonAudioController)
local get_CurrentCharacterLength = function(self)
    print('get_CurrentCharacterLength')
    return 0;
end
xlua.hotfix(CS.CommonAudioController,'get_CurrentCharacterLength',get_CurrentCharacterLength)