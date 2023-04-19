-- table
getgenv().catgirlcc = {
    enabled = true,

    predict_movement = true,
    movement_prediction_type = 'catgirl.cc', -- // Roblox ( Uses Roblox velocity. ), catgirl.cc ( Uses catgirl.cc's custom velocity writer. ) [DONE]
    movement_prediction = 0.119,

    hitpart_table = {'Head', 'HumanoidRootPart'}, -- [DONE]
    use_closest_part = true, -- // Ignores the hitpart table. [DONE]
    closest_part_mode = 'Point', -- // Point, Part [DONE]
    visualize_silent = false, -- // Draws a dot on the position you will be shooting.

    fov = {
        type = 'Static', -- // Static [DONE], Dynamic

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

catgirlcc.functions.get_closest_point = function(player) -- i don't think this works >:(
    local mousePosition = game:GetService("UserInputService"):GetMouseLocation()

    local ray = CurrentCamera:ViewportPointToRay(mousePosition.X, mousePosition.Y)

    local closest_part = nil
    local dist = math.huge

    for i, part in pairs(player.Character:GetChildren()) do
        if table.find({'Part', 'BasePart', 'MeshPart'}, part.ClassName) then
            if not catgirlcc.use_closest_part and table.find(catgirlcc.hitpart_table, part.Name) then
                local mag = (part.Position - ray.Origin):Dot(ray.Direction)
                if mag < dist then
                    closest_part = part
                    dist = mag
                end
            elseif catgirlcc.use_closest_part then
                local mag = (part.Position - ray.Origin):Dot(ray.Direction)
                if mag < dist then
                    closest_part = part
                    dist = mag
                end
            end
        end
    end
    return ray.Origin + ray.Direction * dist
end

catgirlcc.functions.is_gun = function(tool, state)
    if tool:IsA('Tool') and table.find(table, tool.Name)
        if state == 'value' then
            return true
        elseif state == 'tool' then
            return tool
        end
    end
end

catgirlcc.functions.aim_check = function(player)
    if catgirlcc.checks.downed_check and player and player.Character then
        if player.Character.BodyEffects["K.O"].Value then
            return true
        end
    end
    if catgirlcc.checks.grabbed_check and player and player.Character then
        if player.Character:FindFirstChild("GRABBING_CONSTRAINT") then
            return true
        end
    end
    if catgirlcc.checks.crew_check and player and player.Character then
        -- do when home !!!!
    end
    if catgirlcc.checks.friend_check and player:IsFriendsWith(LocalPlayer.UserId) then
        return true
    end
    return false
end

catgirlcc.functions.calculate_aimpoint = function()
    if catgirlcc.target ~= nil then
        catgirlcc.current_aimpart = catgirlcc.functions.get_closest_part(catgirlcc.target)

        if catgirlcc.closest_part_mode == 'Point' then
            catgirlcc.current_aimpos = catgirlcc.functions.get_closest_point(catgirlcc.current_aimpart)
        else
            catgirlcc.current_aimpos = catgirlcc.current_aimpart.Position
        end

        if typeof(catgirlcc.current_aimpos) == 'CFrame' then
            catgirlcc.current_aimpos = catgirlcc.current_aimpos.p
        end
    end
end

catgirlcc.connections.service = RunService.Heartbeat:Connect(function()
    catgirlcc.functions.update_fov()
    catgirlcc.functions.set_aim()
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(child)
        if catgirlcc.functions.is_gun(child) then
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