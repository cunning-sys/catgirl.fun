-- table
getgenv().catgirlcc = {
    enabled = true,

    predict_movement = true,
    movement_prediction_type = 'catgirl.cc', -- // Roblox ( Uses Roblox velocity. ), catgirl.cc ( Uses catgirl.cc's custom velocity writer. )
    movement_prediction = 0.119,

    hitpart_table = {'Head', 'HumanoidRootPart'},
    use_closest_part = true,
    closest_part_mode = 'Point', -- // Point, Part
    visualize_silent = false,

    fov = {
        visible = false,
        filled = false,
        radius = 8,
        color = Color3.fromRGB(0, 0, 0),

        gun_fov = {
            enabled = false,

            ['[Revolver]'] = {fov_radius = 13, movement_prediction = 0.119},
            ['[Double-Barrel SG]'] = {fov_radius = 25, movement_prediction = 0.134},
            ['[TacticalShotgun]'] = {fov_radius = 20, movement_prediction = 0.128},
            ['[Shotgun]'] = {fov_radius = 20, movement_prediction = 0.128} -- you can add your own guns :3
        }
    },
    checks = {
        wall_check = true,
        screen_check = true,
        downed_check = true,
        grabbed_check = true,
        crew_check = false,
        friend_check = false
    },
    settings = {
        target_type = 'FOV', -- // FOV, Target
        target_keybind = 'c',
        mode = 'Safe' -- // Safe ( Bypasses aim viewer. ), Blatant ( Uses hook doesn't bypass aim viewer. )
    }
}
-- functions/connections
catgirlcc.functions = {}
catgirlcc.connections = {}
-- vars
local Workspace = game:GetService('Workspace')
local CurrentCamera = Workspace.CurrentCamera

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

catgirlcc.functions.get_closest_player = function()
    local dist = math.huge
    local player = nil

    for i,v ipairs(Players:GetPlayers()) do
