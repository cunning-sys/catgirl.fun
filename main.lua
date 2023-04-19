-- table
getgenv().catgirlcc = {
    enabled = true,

    predict_movement = true,
    movement_prediction_type = 'catgirl.cc', -- // Roblox ( Uses Roblox velocity. ), catgirl.cc ( Uses catgirl.cc's custom velocity writer. ) [DONE]
    movement_prediction = 0.119,
    auto_movement_prediction = {
        enabled = true,

        p10_20 = 0,
        p20_30 = 0,
        p30_40 = 0,
        p40_50 = 0,
        p50_60 = 0,
        p60_70 = 0,
        p70_80 = 0,
        p80_90 = 0,
        p90_100 = 0,
        p100_110 = 0,
        p110_120 = 0,
        p120_130 = 0,
        p130_140 = 0,
        p140_150 = 0,
        p150_160 = 0,
        p160_170 = 0,
        p170_180 = 0,
        p180_190 = 0,
        p190_200 = 0
    },

    hitpart_table = {'Head', 'HumanoidRootPart'}, -- [DONE]
    use_closest_part = true, -- // Ignores the hitpart table. [DONE]
    closest_part_mode = 'Point', -- // Point, Part [DONE]
    visualize_silent = { -- // Draws a dot on the position you will be shooting. [DONE]
        enabled = false,

        dot = {
            enabled = false,

            dot_radius = 5,
            dot_thickness = 1,
            dot_transparency = 0,
            dot_filled = false,
            dot_color = {solid = Color3.fromRGB(255, 255, 255), rainbow = false}
        },
        tracer = {
            enabled = false,

            tracer_thickness = 1,
            tracer_transparency = 0,
            tracer_color = {solid = Color3.fromRGB(255, 255, 255), rainbow = false}
        }
    },

    fov = {
        type = 'Static', -- // Static [DONE], Dynamic [NOT DONE]

        visible = false,
        filled = false,
        radius = 8,
        color = Color3.fromRGB(0, 0, 0),

        gun_settings = {
            enabled = false, -- [DONE]

            ['[Revolver]'] = {fov_radius = 13, movement_prediction = 0.119},
            ['[Double-Barrel SG]'] = {fov_radius = 25, movement_prediction = 0.134},
            ['[TacticalShotgun]'] = {fov_radius = 20, movement_prediction = 0.128},
            ['[Shotgun]'] = {fov_radius = 20, movement_prediction = 0.128} -- you can add your own guns :3
        }
    },
    checks = {
        wall_check = true, -- [DONE]
        downed_check = true, -- [DONE]
        grabbed_check = true, -- [DONE]
        crew_check = false,
        friend_check = false
    },
    settings = {
        target_type = 'FOV', -- // FOV [DONE], Target
        target_keybind = 'c',
        mode = 'Safe' -- // Safe ( Bypasses aim viewer. ), Blatant ( Uses hook doesn't bypass aim viewer. ) DONE

        safety = {
            unload = {
                enabled = false,
                keybind = 'z'
            },
            kick_on_staff_join = true,
        }
    }
}
-- functions/connections
catgirlcc.functions = {}
catgirlcc.connections = {}
catgirlcc.unloaded = false
catgirlcc.connections.tools = {nil, nil}
catgirlcc.args = nil
catgirlcc.current_aimpos = nil
catgirlcc.current_aimpart = nil
catgirlcc.target = nil
-- vars
local Workspace = game:GetService('Workspace')
local CurrentCamera = Workspace.CurrentCamera

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GetGuiInset = game:GetService("GuiService"):GetGuiInset()
local RunService = game:GetService('RunService')
local Remote = nil

local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall

if game.PlaceId == 5602055394 then
    Remote = game:GetService('ReplicatedStorage').Bullets
else
    if game:GetService('ReplicatedStorage'):FindFirstChild('MainEvent') then
        Remote = game:GetService('ReplicatedStorage').MainEvent
    end
end

local fov_circle = Drawing.new('Circle')
fov_circle.Thickness = 0.8
fov_circle.Transparency = 0.7
fov_circle.Color = catgirlcc.fov.color

local visualized_dot = Drawing.new('Circle')
local visualized_tracer = Drawing.new('Line')

--[[
    <void> catgirlcc.functions.update_fov()
]]--

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

-- use mouse.KeyDown
catgirlcc.functions.keybinds = function(inputObject, IsTyping)
    if IsTyping then return end
    if inputObject.KeyCode == Enum.KeyCode[catgirlcc.settings.safety.keybind:Upper()] and catgirlcc.settings.safety.enabled then
        catgirlcc.connections.service:Disconnect()
        catgirlcc.connections.keybinds:Disconnect()
    end

    if inputObject.KeyCode == Enum.KeyCode[catgirlcc.settings.target_keybind:Upper()] then
        -- not done !!! do after fov mode
    end
end

--[[
    <void> catgirlcc.functions.unload()
]]--

catgirlcc.functions.unload = function()
    if catgirlcc.settings.safety.unload.enabled and not catgirlcc.unload then
        for i,v in next, catgirlcc.connections do
            v:Disconnect()
        end
    end
end

--[[
    <void> catgirlcc.functions.is_visible(part, partparent)
]]--

catgirlcc.functions.is_visible = function(part, partparent)
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
            local is_visible = not hit or hit:IsDescendantOf(partparent)

            return is_visible
        end
    end
    return false
end
--[[
    <void> catgirlcc.functions.get_closest_player()
]]--
catgirlcc.functions.get_closest_player = function()
    local dist = math.huge
    local cplayer = nil

    for i, player in ipairs(Players:GetPlayers()) do
        if player.Character and player ~= LocalPlayer and catgirlcc.functions.aim_check(player) then
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
--[[
    <void> catgirlcc.functions.get_closest_part(player)
]]--
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

--[[
    <void> catgirlcc.functions.get_closest_point(part)
]]--

catgirlcc.functions.get_closest_point = function(part)
    local trans = part.CFrame:pointToObjectSpace(Mouse.Hit.Position)
    local size = part.Size * 0.5

    return part.CFrame * Vector3.new(math.clamp(trans.X, -size.X, size.x), math.clamp(trans.Y, -size.Y, size.Y), math.clamp(trans.Z, -size.Z, size.Z))
end

--[[
    <void> catgirlcc.functions.is_gun(tool, state - 'value', 'tool')
]]--

catgirlcc.functions.is_gun = function(tool, state)
    if tool:IsA('Tool') and table.find(table, tool.Name)
        if state == 'value' then
            return true
        elseif state == 'tool' then
            return tool
        end
    end
end

--[[
    <void> catgirlcc.functions.get_prediction()
]]--

catgirlcc.functions.get_prediction = function()
    if catgirlcc.predict_movement then
        return catgirlcc.movement_prediction
    elseif not catgirlcc.predict_movement then
        return 0
    end
end

--[[
    <void> catgirlcc.functions.auto_movement_prediction()
]]--

catgirlcc.functions.auto_movement_prediction = function() -- add in the values when im home
    if catgirlcc.auto_movement_prediction.enabled then
        local ping --idk the path
        if ping > 10 then
            catgirlcc.movement_prediction = catgirlcc.auto_movement_prediction.p10_20
        elseif ping > 20 then

        elseif ping > 30 then

        elseif ping > 40 then
        
        elseif ping > 50 then

        elseif ping > 60 then

        elseif ping > 70 then

        elseif ping > 80 then

        elseif ping > 90 then
        
        elseif ping > 100 then
        
        elseif ping > 100 then

        elseif ping > 110 then

        elseif ping > 120 then

        elseif ping > 130 then

        elseif ping > 140 then

        elseif ping > 150 then

        elseif ping > 160 then

        elseif ping > 170 then

        elseif ping > 180 then

        elseif ping > 190 then

        elseif ping > 200 then

    end
end

--[[
    <void> catgirlcc.functions.draw_visualized_point()
]]--

catgirlcc.functions.draw_visualized_point = function()
    if not (visualized_dot or visualized_tracer) then
        return visualized_dot or visualized_tracer
    end

    if
end

--[[
    <void> catgirlcc.functions.aim_check(player)
]]--

catgirlcc.functions.aim_check = function(player)
    if catgirlcc.checks.downed_check and player and player.Character then
        if player.Character.BodyEffects["K.O"].Value then
            return false
        end
    end
    if catgirlcc.checks.grabbed_check and player and player.Character then
        if player.Character:FindFirstChild("GRABBING_CONSTRAINT") then
            return false
        end
    end
    if catgirlcc.checks.crew_check and player then
        -- done at home
    end
    if catgirlcc.checks.friend_check and player:IsFriendsWith(LocalPlayer.UserId) then
        return false
    end
    return true
end

--[[
    <void> catgirlcc.functions.calculate_aimpoint()
]]--

catgirlcc.functions.calculate_aimpoint = function()
    if catgirlcc.target ~= nil then
        catgirlcc.current_aimpart = catgirlcc.functions.get_closest_part(catgirlcc.target)

        if catgirlcc.closest_part_mode == 'Point' then
            catgirlcc.current_aimpos = catgirlcc.functions.get_closest_point(catgirlcc.current_aimpart)
        else
            catgirlcc.current_aimpos = catgirlcc.current_aimpart.Position
        end

        if catgirlcc.movement_prediction_type == 'catgirl.cc' then
            local velocity = catgirlcc.target.Character.Humanoid.MoveDirection * 16
            catgirlcc.current_aimpos = catgirlcc.current_aimpos + velocity * catgirlcc.functions.get_prediction()
        elseif catgirlcc.movement_prediction_type == 'Roblox' then
            local velocity = catgirlcc.current_aimpart.Velocity
            local resolved_velocity = catgirlcc.target.Character.Humanoid.MoveDirection * 16

            if (velocity.Magnitude > -40 or velocity.Magnitude < 80) then
                catgirlcc.current_aimpos = catgirlcc.current_aimpos + resolved_velocity * catgirlcc.functions.get_prediction()
            else
                catgirlcc.current_aimpos = catgirlcc.current_aimpos + velocity * catgirlcc.functions.get_prediction()
            end
        end

        if typeof(catgirlcc.current_aimpos) == 'CFrame' then
            catgirlcc.current_aimpos = catgirlcc.current_aimpos.p
        end
    end
end

catgirlcc.connections.mainservice = RunService.Heartbeat:Connect(function()
    catgirlcc.functions.update_fov()
    catgirlcc.functions.calculate_aimpoint()
    if catgirlcc.settings.target_type == 'FOV' then
        catgirlcc.functions.get_closest_player()
    end
    if catgirlcc.auto_movement_prediction then
        catgirlcc.functions.auto_movement_prediction()
    end
end)

catgirlcc.connections.charadded = LocalPlayer.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(child)
        if catgirlcc.functions.is_gun(child, 'value') then
            if catgirlcc.connections.tools[1] == nil then
                catgirlcc.connections.tools[1] = child
            end
            if catgirlcc.connections.tools[1] ~= child and catgirlcc.connections.tools[2] ~= nil then
                catgirlcc.connections.tools[2]:Disconnect()
                catgirlcc.connections.tools[1] = child
            end

            catgirlcc.connections.tools[2] = child.Activated:Connect(function()
                if catgirlcc.target and catgirlcc.current_aimpos and catgirlcc.settings.mode == 'Safe' then
                    Remote:FireServer(catgirlcc.args, catgirlcc.current_aimpos)
                end
            end)

            -- gun settings [finish home]
            if catgirlcc.fov.gun_settings.enabled then
                local gun = catgirlcc.functions.is_gun(child, 'tool')

                if gun[catgirlcc.fov.gun_settings] then
                    
                end
            end
        end
    end)
end)

local __namecall
__namecall = hookmetamethod(game, '__namecall', function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if tostring(self.Name) == 'MainEvent' and tostring(method) == 'FireServer' then
        if table.find({'TeleportDetect', 'CHECKER_1', 'CHECKER', 'GUI_CHECK', 'OneMoreTime', 'checkingSPEED', 'BANREMOTE', 'KICKREMOTE', 'BR_KICKPC', 'BR_KICKMOBILE'}, args[1]) then
            return
        end
    end
end)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if catgirlcc.settings.mode == 'Safe' and catgirlcc.target and catgirlcc.current_aimpos then
        if typeof(args[2]) == 'Vector3' then
            args[2] = current_aimpos
        end
        return backupnamecall(self, unpack(args))
    end

    if typeof(args[2]) == 'Vector3' then
        catgirlcc.args = args[2]
    end
end)

--[[
local __index
__index = hookmetamethod(game,"__index", function(Obj, Property)
    if Obj:IsA("Mouse") and Property == "Hit" then
        if catgirlcc.enabled then
            catgirlcc.target = catgirlcc.functions.get_closest_player()
            if catgirlcc.target and not catgirlcc.functions.aim_check(catgirlcc.target) then
                local predicted_pos = target.Character.Humanoid.MoveDirection * 16
                local ending_pos = CFrame.new([catgirlcc.target].Character[catgirlcc.current_aimpos].Position + predicted_pos)

                return ending_pos
            end
        end
    end
    return __index(Obj, Property)
end)]]