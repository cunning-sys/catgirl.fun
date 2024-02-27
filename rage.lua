local RageModule = {
    Blatant = {
        Exploits = {
            AutoStomp = nil,
            AntiBag = nil,
        },
        GunModifications = {
            AutoReload = nil,
        }
        Visuals = {
            Local = {
                Chams = nil,
                GunChams = nil,
                Highlight = {
                    Enabled = nil,
                    FillColor = nil,
                    OutlineColor = nil,
                },
                CloneChams = {
                    Enabled = nil,
                    Duration = nil,
                    Color = nil,
                    Material = nil
                }
            },
        }
    }
}


local circleinstance = Drawing.new("Circle")
local circleinstancex = Drawing.new("Circle")
RunService.Heartbeat:Connect(function ()
    if AimbotDrawFOV then
        circleinstance.Position = Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y + game:GetService("GuiService"):GetGuiInset().Y)
        circleinstance.Visible = true
        circleinstance.Thickness = 2
        circleinstance.Radius =	AimbotFOVSize
        circleinstance.NumSides = 60
        circleinstance.Color = AimbotFOVClr
    else
        circleinstance.Visible = false
    end
    if TargetFOvEnabled then
        circleinstancex.Position = Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y + game:GetService("GuiService"):GetGuiInset().Y)
        circleinstancex.Visible = true
        circleinstancex.Thickness = 2
        circleinstancex.Radius = TargetFOVSize
        circleinstancex.NumSides = 60
        circleinstancex.Color = TargetFovClr
    else
        circleinstancex.Visible = false
    end
    if RageModule.Blatant.Exploits.AutoStomp then
        game.ReplicatedStorage.MainEvent:FireServer("Stomp")
    end
    if RageModule.Blatant.Exploits.AntiBag then
        if LocalPlayer.Character["Christmas_Sock"] then
            LocalPlayer.Character["Christmas_Sock"]:Destroy()
        end
    end
    if RageModule.Blatant.AntiStomp.Enabled then
        if LocalPlayer.Character.Humanoid.Health <= 1 then
            if RageModule.Blatant.AntiStomp.Type == "Remove Character" then
                for i, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v:Destroy()
                    end
                end
            elseif RageModule.Blatant.AntiStomp.Type == "Remove Humanoid" then
                LocalPlayer.Character.Humanoid:Destroy()
            end
        end
    end
    if RageModule.Blatant.GunModifications.AutoReload then
        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
            if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
                if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                    game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")) 
                end
            end
        end
    end
end)

task.spawn(function ()
    while true do
        wait()
        if RageModule.Visuals.Local.Chams then
            for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = "ForceField"
                end
            end
        else
            for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = "Plastic"
                end
            end
        end
    end
end)

task.spawn(function ()
    while true do
        wait()
        if RageModule.Visuals.Local.GunChams.Enabled then
            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Material = "ForceField"
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Color = RageModule.Visuals.Local.GunChams.Color
            end
        else
            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Material = "Plastic"
            end
        end
    end
end)
