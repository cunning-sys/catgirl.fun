local cheat = {functions = {}, connections = {}}

function cheat.functions.getcrewname(plr)
    if plr.DataFolder.Information:FindFirstChild('Crew') and not plr.DataFolder.Information.Crew.Value == '' then
        return game:GetService('GroupService'):GetGroupInfoAsync(plr.DataFolder.Information.Crew.Value).Name
    else
        return 'nil'
    end
end

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cunning-sys/catgirl.fun/main/ui-library.lua'))()

local window = library:Load({
    title = 'catgirl.cc',
    discord = '9FawWVxcpG',
    playerlist = true,
    playerlistmax = 40
})

library.playerlist:Label({name = 'Crew: ', handler = function(plr)
    return cheat.functions.getcrewname(plr)
end})

library.playerlist:Label({name = 'Bounty: ', handler = function(plr)
    return plr.DataFolder.Information.Wanted.Value
end})

local aiming_tab = window:Tab('aiming')
local bulletredirect_sec = aiming_tab:Section({name = 'bullet-redirection', side = 'Left'})
local targetaim_sec = aiming_tab:Section({name = 'target-aim', side = 'Middle'})
local aimassist_sec = aiming_tab:Section({name = 'aim-assist', side = 'Right'})

local visuals_tab = window:Tab('visuals')
local esp_sec = visuals_tab:Section({name = 'esp', side = 'Left'})

library:Init()
