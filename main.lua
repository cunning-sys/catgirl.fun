-- table
getgenv().catgirlcc = {
    enabled = true,

    predict_movement = true,
    movement_prediction_type = 'catgirl.cc', -- // Roblox ( Uses Roblox velocity. ), catgirl.cc ( Uses catgirl.cc's custom velocity writer. )
    movement_prediction = 0.119,

    hitpart_table = {'Head', 'HumanoidRootPart'},
    use_closest_part = true, -- // Ignores the hitpart table.
    closest_part_mode = 'Point', -- // Point, Part
    visualize_silent = false, -- // Draws a dot on the position you will be shooting.

    fov = {
        type = 'Static', -- // Static, Dynamic

        visible = false,
        filled = false,
        radius = 8,
        color = Color3.fromRGB(0, 0, 0),

        gun_settings = {
            enabled = false,

            ['[Revolver]'] = {fov_radius = 13, movement_prediction = 0.119},
            ['[Double-Barrel SG]'] = {fov_radius = 25, movement_prediction = 0.134},
            ['[TacticalShotgun]'] = {fov_radius = 20, movement_prediction = 0.128},
            ['[Shotgun]'] = {fov_radius = 20, movement_prediction = 0.128} -- you can add your own guns :3
        }
    },
    checks = {
        wall_check = true,
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
catgirlcc.current_hitpos = nil
-- vars
local Workspace = game:GetService('Workspace')
local CurrentCamera = Workspace.CurrentCamera

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GetGuiInset = game:GetService("GuiService"):GetGuiInset()
local RunService = game:GetService('RunService')

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

catgirlcc.functions.is_visible = function(part, partdescendant)
    if not catgirlcc.checks.wall_check then
        return true
    end

    local char = LocalPlayer.Character
    local campos = CurrentCamera.CFrame.Position
    local _, on_screen = CurrentCamera:WorldToViewportPoint(part)

    if on_screen then
        local raycastparams = RaycastParams.new()
        raycastparams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastparams.FilterDescendantsInstances = {char, CurrentCamera}

        local results = Workspace:Raycast(campos, part.Position - campos, raycastparams)

        if results then
            local hit = results.Instance
            local is_visible = not hit or hit:IsDescendantOf(partdescendant)

            return is_visible
        end
    end
    return false
end

catgirlcc.functions.get_closest_player = function()
    local dist = math.huge
    local cplayer = nil

    for i, player in ipairs(Players:GetPlayers()) do
        if player.Character and player ~= LocalPlayer then
            local pos = player.Character:GetBoundingBox().Position
            if pos then continue end

            local _, on_screen = CurrentCamera:WorldToViewportPoint(pos)
            if on_screen then
                local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(on_screen.X, on_screen.Y)).Magnitude
                if fov_circle.Radius > mag and mag < dist then
                    cplayer = player
                    dist = mag
                end
            end
        end
    end
    return cplayer
end

catgirlcc.functions.get_closest_part = function(player)
    local closest_part = nil
    local dist = math.huge

    for i, part in pairs(player.Character:GetChildren()) do
        if table.find({'Part', 'BasePart', 'MeshPart'}, part.ClassName) then
            if not catgirlcc.use_closest_part and table.find(catgirlcc.hitpart_table, part.Name) then continue elseif catgirlcc.use_closest_part then continue end

            local on_screen = CurrentCamera:WorldToViewportPoint(part.Position)
            local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(on_screen.X, on_screen.Y)).Magnitude

            if mag < dist and catgirlcc.functions.is_visible(part, part.Parent) then
                closest_part = part
                dist = mag
            end
        end
    end
    return closest_part
end

catgirlcc.functions.get_closest_point = function(player) -- i don't think this work >:(
    local mousePosition = game:GetService("UserInputService"):GetMouseLocation()

    local ray = CurrentCamera:ViewportPointToRay(mousePosition.X, mousePosition.Y)

    local closestPart = nil
    local closestDistance = math.huge

    for i, part in pairs(player.Character:GetChildren()) do
        if table.find({'Part', 'BasePart', 'MeshPart'}, part.ClassName) then
            if not catgirlcc.use_closest_part and table.find(catgirlcc.hitpart_table, part.Name) then
                local distance = (part.Position - ray.Origin):Dot(ray.Direction)
                if distance < closestDistance then
                    closestPart = part
                    closestDistance = distance
                end
            elseif catgirlcc.use_closest_part then
                local distance = (part.Position - ray.Origin):Dot(ray.Direction)
                if distance < closestDistance then
                    closestPart = part
                    closestDistance = distance
                end
            end
        end
    end
    return ray.Origin + ray.Direction * closestDistance
end

catgirlcc.functions.get_aim = function()
    local target = get_closest_player()

    if catgirlcc.closest_part_mode == 'Part' then
        local part = catgirlcc.functions.get_closest_part(target)

        catgirlcc.current_hitpos = tostring(part)
    elseif catgirlcc.closest_part_mode == 'Point' then
        -- not done 3:
    end
end

catgirlcc.connections.service = RunService.Heartbeat:Connect(function()
    catgirlcc.functions.update_fov()
end)

local __index
__index = hookmetamethod(game,"__index", function(Obj, Property)
    if Obj:IsA("Mouse") and Property == "Hit" then
        local target = catgirlcc.functions.get_aim()
        if catgirlcc.enabled and target and not catgirlcc.functions.aim_check(target) then
            local predicted_pos = target.Character.Humanoid.MoveDirection * 16
            local ending_pos = target.Character[].
            return predictedPosition
        end
    end
    return __index(Obj, Property)
end)