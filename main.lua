-- table
getgenv().catgirlcc = {
    enabled = true,

    predict_movement = true,
    movement_prediction_type = 'catgirl.cc', -- // Roblox ( Uses Roblox velocity. ), catgirl.cc ( Uses catgirl.cc's custom velocity writer. )
    movement_prediction = 0.119,

    hitpart_table = {'Head', 'HumanoidRootPart'}
    use_closest_part = true,
    closest_part_mode = 'Point', -- // Point, Part

    fov_visible = false,
    fov_filled = false,
    fov_radius = 8,
    fov_color = Color3.fromRGB(0, 0, 0),
    visualize_silent = false,

    target_type = 'FOV', -- // FOV, Target
    target_keybind = 'c',
    mode = 'Safe' -- // Safe ( Bypasses aim viewer. ), Blatant ( Uses hook doesn't bypass aim viewer. )
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