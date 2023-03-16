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
local Mouse = LocalPlayer:GetMouse()
local GetGuiInset = game:GetService("GuiService"):GetGuiInset()

local fov_circle = Drawing.new('Circle')
fov_circle.Thickness = 0.8
fov_circle.Transparency = 0.7
fov_circle.Color = catgirlcc.fov.color

catgirlcc.functions.update_fov = function()
    if not (fov_circle) then
        return fov_circle
    end
    fov_circle.Radius =  catgirlcc.fov.radius * 3
    fov_circle.Visible = catgirlcc.fov.visible
    fov_circle.Filled = catgirlcc.fov.filled
    fov_circle.Position = Vector2.new(Mouse.X, Mouse.Y + (GetGuiInset.Y))
    return fov_circle
end

catgirlcc.functions.get_closest_player = function()
    local dist = math.huge
    local player = nil

    for i, player in ipairs(Players:GetPlayers()) do
        if player
end

catgirlcc.functions.get_closest_point = function(player)
    local mousePosition = game:GetService("UserInputService"):GetMouseLocation()

    local ray = CurrentCamera:ViewportPointToRay(mousePosition.X, mousePosition.Y)

    local closestPart = nil
    local closestDistance = math.huge

    for i, part in pairs(player.Character:GetDescendants()) do
        if table.find({'Part', 'BasePart', 'MeshPart'}, part.ClassName) then
            local distance = (part.Position - ray.Origin):Dot(ray.Direction)
            if distance < closestDistance then
                closestPart = part
                closestDistance = distance
            end
        end
    end
    return ray.Origin + ray.Direction * closestDistance
end