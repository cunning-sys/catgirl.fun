local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

local Storage = {
    Targets = {
        AimAssistTarget;
        BulletRedirectionTarget;
    },
    Settings = {
        AutoPredictionValue;
    },
    Functions = {

    },
    Drawings = {
        AimAssist = {
            outside_circle = Drawing.new('Circle');
            inside_circle = Drawing.new('Circle');
            filled_circle = Drawing.new('Circle');
            main_circle = Drawing.new('Circle');
        },
        BulletRedirection = {
            outside_circle = Drawing.new('Circle');
            inside_circle = Drawing.new('Circle');
            filled_circle = Drawing.new('Circle');
            main_circle = Drawing.new('Circle');
        }
    }
}

do -- aim assist fov
    Storage.Drawings.AimAssist.outside_circle.Visible = false
    Storage.Drawings.AimAssist.outside_circle.Radius = 35 - 1.5
    Storage.Drawings.AimAssist.outside_circle.Color = Color3.fromRGB(0, 0, 0)
    Storage.Drawings.AimAssist.outside_circle.Thickness = 1.5

    Storage.Drawings.AimAssist.inside_circle.Visible = false
    Storage.Drawings.AimAssist.inside_circle.Radius = 35 + 1.5
    Storage.Drawings.AimAssist.inside_circle.Color = Color3.fromRGB(0, 0, 0)
    Storage.Drawings.AimAssist.inside_circle.Thickness = 1.5

    Storage.Drawings.AimAssist.filled_circle.Visible = false
    Storage.Drawings.AimAssist.filled_circle.Radius = 35 - 1.5
    Storage.Drawings.AimAssist.filled_circle.Color = Color3.fromRGB(133, 87, 242)
    Storage.Drawings.AimAssist.filled_circle.Thickness = 1.5
    Storage.Drawings.AimAssist.filled_circle.ZIndex = 5
    Storage.Drawings.AimAssist.filled_circle.Filled = true

    Storage.Drawings.AimAssist.main_circle.Visible = false
    Storage.Drawings.AimAssist.main_circle.Radius = 35
    Storage.Drawings.AimAssist.main_circle.Color = Color3.fromRGB(255, 255, 255)
    Storage.Drawings.AimAssist.main_circle.Thickness = 2
end

do -- bullet redirection fov
    Storage.Drawings.BulletRedirection.outside_circle.Visible = false
    Storage.Drawings.BulletRedirection.outside_circle.Radius = 35 - 1.5
    Storage.Drawings.BulletRedirection.outside_circle.Color = Color3.fromRGB(0, 0, 0)
    Storage.Drawings.BulletRedirection.outside_circle.Thickness = 1.5

    Storage.Drawings.BulletRedirection.inside_circle.Visible = false
    Storage.Drawings.BulletRedirection.inside_circle.Radius = 35 + 1.5
    Storage.Drawings.BulletRedirection.inside_circle.Color = Color3.fromRGB(0, 0, 0)
    Storage.Drawings.BulletRedirection.inside_circle.Thickness = 1.5

    Storage.Drawings.BulletRedirection.filled_circle.Visible = false
    Storage.Drawings.BulletRedirection.filled_circle.Radius = 35 - 1.5
    Storage.Drawings.BulletRedirection.filled_circle.Color = Color3.fromRGB(133, 87, 242)
    Storage.Drawings.BulletRedirection.filled_circle.Thickness = 1.5
    Storage.Drawings.BulletRedirection.filled_circle.ZIndex = 5
    Storage.Drawings.BulletRedirection.filled_circle.Filled = true

    Storage.Drawings.BulletRedirection.main_circle.Visible = false
    Storage.Drawings.BulletRedirection.main_circle.Radius = 35
    Storage.Drawings.BulletRedirection.main_circle.Color = Color3.fromRGB(255, 255, 255)
    Storage.Drawings.BulletRedirection.main_circle.Thickness = 2
end

Storage.Drawings.AimAssist.
Storage.Drawings.BulletRedirection.

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/cunning-sys/catgirl.fun/main/ui.lua'),true))()
local esp = loadstring(game:HttpGet(('https://raw.githubusercontent.com/cunning-sys/catgirl.fun/main/esp.lua'),true))()

esp.team_healthbar[2] = Color3.fromRGB(0, 255, 0)
esp.team_healthbar[3] = Color3.fromRGB(255, 0, 0)
esp.team_kevlarbar[2] = Color3.fromRGB(135, 206, 235)
esp.team_kevlarbar[3] = Color3.fromRGB(0, 0, 255)

local Window = library:New({ Name = '<font color=\"#8557F2\">catgirl.fun</font> | da hood', Accent = Color3.fromRGB(133, 87, 242), sizeX = 600, sizeY = 500})
local Pages = {
    Aiming = Window:Page({ Name = "combat" }),
    Visuals = Window:Page({ Name = "visuals" }),
    Misc = Window:Page({ Name = "misc" }),
    Config = Window:Page({ Name = "configurations" })
}
local Sections = {
	Combat = {
		AimAssist = Pages.Aiming:Section({ Name = "aim-assist", Side = "Left" }),
        AimAssistSettings = Pages.Aiming:Section({ Name = "aim-assist settings", Side = "Left" }),
		BulletRedirection = Pages.Aiming:Section({ Name = "bullet-redirection", Side = "Right" }),
        Targetting = Pages.Aiming:Section({ Name = "bullet-redirection targetting", Side = "Right" }),
		Modifications = Pages.Aiming:Section({ Name = "modifications", Side = "Left" }),
		BulletRedirectionSettings = Pages.Aiming:Section({ Name = "bullet-redirectionsettings", Side = "Right" })
	},
	Visuals = {
		Players = Pages.Visuals:Section({ Name = "players", Side = "Left" }),
		Self = Pages.Visuals:Section({ Name = "self", Side = "Right" }),
		Models = Pages.Visuals:Section({ Name = "models", Side = "Left" }),
		World = Pages.Visuals:Section({ Name = "world", Side = "Right" })
	},
	Misc = {
		SkinChanger =  Pages.Misc:Section({ Name = "skin-changer", Side = "Left" }),
	},
	Config = {
		Configs = Pages.Config:Section({ Name = "configuration", Side = "Left" }),
        Utilities = Pages.Config:Section({ Name = "utilities", Side = "Right" })
	}
}

local Combat = {
    AimAssist = {
        Enabled = Sections.Combat.AimAssist:Toggle({
            Name = "enabled",
            Default = false,
            Pointer = "aimassist",
            callback = function(state)
                print(state)
            end
        }),
        AimAssistBind = Sections.Combat.AimAssist:Keybind({
            Name = "aim-assist bind",
            Default = Enum.KeyCode.Q,
            Blacklist = { Enum.UserInputType.MouseButton1 },
            Flag = "aimassistbind",
            Callback = function(key, fromsetting)
                if not fromsetting then
                    print('aiming!')
                end
            end
        }),
        Method = Sections.Combat.AimAssist:Dropdown({
            Name = "method",
            Options = {"Mouse", "Camera"},
            Default = "Camera",
            Pointer = "aimassistmethod",
            callback = function(state)
                print(state)
            end
        }),
        Hitboxes = Sections.Combat.AimAssist:Dropdown({
            Name = "hitboxes",
            Options = {"Head", "UpperTorso", "RightUpperArm", "RightLowerArm", "RightUpperArm", "LeftUpperArm", "LeftLowerArm", "LeftFoot", "RightFoot", "LowerTorso", "LeftHand", "RightHand", "RightUpperLeg", "LeftUpperLeg", "LeftLowerLeg", "RightLowerLeg"},
            Pointer = "aimassisthitbox",
            Maximum = 16,
            callback = function(state)
                print(state)
            end
        }),
        Sensitivity = Sections.Combat.AimAssist:Slider({
            Name = "sensitivity",
            Minimum = 0,
            Maximum = 10,
            Default = 2,
            Decimals = 0.000000000000000001,
            Pointer = "aimassistsensitivity",
            callback = function(state)
                print(state)
            end
        }),
        Smoothing = Sections.Combat.AimAssist:Slider({
            Name = "smoothing",
            Minimum = 0,
            Maximum = 1,
            Default = 0.35,
            Decimals = 0.000000000000000001,
            Pointer = "aimassistsmoothing",
            callback = function(state)
                print(state)
            end
        }),
        Prediction = Sections.Combat.AimAssist:Toggle({
            Name = "prediction",
            Default = false,
            Pointer = "aimassistprediction",
            callback = function(state)
                print(state)
            end
        }),
        AutoPrediction = Sections.Combat.AimAssist:Toggle({
            Name = "auto prediction",
            Default = false,
            Pointer = "aimassistautoprediction",
            callback = function(state)
                print(state)
            end
        }),
        PredictionValue = Sections.Combat.AimAssist:Box({
            Name = "prediction value",
            Default = '0.135',
            Pointer = 'aimassistpredictionvalue',
            Callback = function(state)
                print(state)
            end
        }),
        AirMode = Sections.Combat.AimAssist:Toggle({
            Name = "air mode",
            Default = false,
            Pointer = "aimassistairmode",
            callback = function(state)
                print(state)
            end
        }),
        AirModeSmoothing = Sections.Combat.AimAssist:Slider({
            Name = "air mode smoothing muliplier",
            Minimum = 0,
            Maximum = 2,
            Default = 1.5,
            Decimals = 0.000000000000000001,
            Pointer = "aimassistairmodesmoothing",
            callback = function(state)
                print(state)
            end
        }),
        Shake = Sections.Combat.AimAssist:Toggle({
            Name = "shake",
            Default = false,
            Pointer = "aimassistshake",
            callback = function(state)
                print(state)
            end
        }),
        ShakeRandomization = Sections.Combat.AimAssist:Toggle({
            Name = "shake randomization",
            Default = false,
            Pointer = "aimassistshakerandomization",
            callback = function(state)
                print(state)
            end
        }),
        ShakeX = Sections.Combat.AimAssist:Slider({
            Name = "shake x",
            Minimum = 1,
            Maximum = 20,
            Default = 10,
            Decimals = 0.000000000000000001,
            Pointer = "aimassistshakex",
            callback = function(state)
                print(state)
            end
        }),
        ShakeY = Sections.Combat.AimAssist:Slider({
            Name = "shake y",
            Minimum = 1,
            Maximum = 20,
            Default = 10,
            Decimals = 0.000000000000000001,
            Pointer = "aimassistshakey",
            callback = function(state)
                print(state)
            end
        }),
        UnlockOnDeath = Sections.Combat.AimAssist:Toggle({
            Name = "unlock on death",
            Default = false,
            Pointer = "aimassistunlockondeath",
            callback = function(state)
                print(state)
            end
        }),
        UnlockOnLocalDeath = Sections.Combat.AimAssist:Toggle({
            Name = "unlock on local death",
            Default = false,
            Pointer = "aimassistunlockonlocaldeath",
            callback = function(state)
                print(state)
            end
        }),
        Conditions = Sections.Combat.AimAssist:Dropdown({
            Name = "conditions",
            Options = {"visible", "knocked", "first person", "third person", "shift lock", "grabbed", "crew", "friend", "forcefield"},
            Pointer = "aimassistconditions",
            Maximum = 9,
            callback = function(state)
                print(state)
            end
        })
    },
	BulletRedirection = {
		Enabled = Sections.Combat.BulletRedirection:Toggle({
            Name = "enabled",
            Default = false,
            Pointer = "bulletredirection",
            callback = function(state)
                print(state)
            end
        }),
		Prediction = Sections.Combat.BulletRedirection:Toggle({
            Name = "prediction",
            Default = false,
            Pointer = "bulletredirectionprediction",
            callback = function(state)
                print(state)
            end
        }),
        AutoPrediction = Sections.Combat.BulletRedirection:Toggle({
            Name = "auto prediction",
            Default = false,
            Pointer = "bulletredirectionautoprediction",
            callback = function(state)
                print(state)
            end
        }),
        PredictionValue = Sections.Combat.BulletRedirection:Box({
            Name = "prediction value",
            Default = '0.135',
            Pointer = 'bulletredirectionpredictionvalue',
            Callback = function(state)
                print(state)
            end
        }),
		HitChance = Sections.Combat.BulletRedirection:Slider({
            Name = "hit-chance",
            Minimum = 1,
            Maximum = 100,
            Default = 100,
            Decimals = 0.000000000000000001,
            Pointer = "hitchancevalue",
            callback = function(state)
                print(state)
            end
        }),
		Hitboxes = Sections.Combat.BulletRedirection:Dropdown({
            Name = "hitboxes",
            Options = {"Head", "UpperTorso", "RightUpperArm", "RightLowerArm", "RightUpperArm", "LeftUpperArm", "LeftLowerArm", "LeftFoot", "RightFoot", "LowerTorso", "LeftHand", "RightHand", "RightUpperLeg", "LeftUpperLeg", "LeftLowerLeg", "RightLowerLeg"},
            Pointer = "bulletredirectionhitbox",
            Maximum = 16,
            callback = function(state)
                print(state)
            end
        }),
        Conditions = Sections.Combat.BulletRedirection:Dropdown({
            Name = "conditions",
            Options = {"visible", "knocked", "grabbed", "crew", "friend", "forcefield"},
            Pointer = "bulletredirectionconditions",
            Maximum = 6,
            callback = function(state)
                print(state)
            end
        })
	},
    Targetting = {
        ForceTarget = Sections.Combat.Targetting:Toggle({
            Name = "force target",
            Default = false,
            Pointer = "forcetarget",
            callback = function(state)
                print(state)
            end
        }),
        ForceTargetBind = Sections.Combat.Targetting:Keybind({
            Name = "force target bind",
            Default = Enum.KeyCode.Q,
            Blacklist = { Enum.UserInputType.MouseButton1 },
            Flag = "forcetargetbind",
            Callback = function(key, fromsetting)
                if not fromsetting then
                    print('target forced!')
                end
            end
        }),
        TargetDot = Sections.Combat.Targetting:Toggle({
            Name = "dot",
            Default = false,
            Pointer = "targetdot",
            callback = function(state)
				print(state)
            end
        }),
        TargetDot = Sections.Combat.Targetting:Toggle({
            Name = "highlight",
            Default = false,
            Pointer = "targethighlight",
            callback = function(state)
				print(state)
            end
        }),
    },
	Modifications = {
		RemoveRecoil = Sections.Combat.Modifications:Toggle({
            Name = "remove recoil",
            Default = false,
            Pointer = "removerecoil",
            callback = function(state)
                print(state)
            end
        }),
        RemoveJumpCooldown = Sections.Combat.Modifications:Toggle({
            Name = "remove jump cooldown",
            Default = false,
            Pointer = "removejumpcooldown",
            callback = function(state)
                print(state)
            end
        }),
        RemoveSlowdown = Sections.Combat.Modifications:Toggle({
            Name = "remove slowdown",
            Default = false,
            Pointer = "removeslowdown",
            callback = function(state)
                print(state)
            end
        }),
	},
	BulletRedirectionSettings = {
		UseFOV = Sections.Combat.BulletRedirectionSettings:Toggle({
            Name = "use fov",
            Default = false,
            Pointer = "bulletredirectionusefov",
            callback = function(state)
                print(state)
            end
        }),
		DrawFOV = Sections.Combat.BulletRedirectionSettings:Toggle({
            Name = "draw fov",
            Default = false,
            Pointer = "bulletredirectiondrawfov",
            callback = function(state)
                Storage.Drawings.BulletRedirection.main_circle.Visible = state
				if library.flags['bulletredirectionfovoutline'] then
					Storage.Drawings.BulletRedirection.inside_circle.Visible = state
					Storage.Drawings.BulletRedirection.outside_circle.Visible = state
				end
                if library.flags['bulletredirectionfovfilled'] then
                    Storage.Drawings.BulletRedirection.filled_circle.Visible = state
                end
            end
        }),
        OutlineFOV = Sections.Combat.BulletRedirectionSettings:Toggle({
            Name = "outline",
            Default = false,
            Pointer = "bulletredirectionfovoutline",
            callback = function(state)
				if library.flags['bulletredirectiondrawfov'] then
                	Storage.Drawings.BulletRedirection.inside_circle.Visible = state
					Storage.Drawings.BulletRedirection.outside_circle.Visible = state
				else
					Storage.Drawings.BulletRedirection.inside_circle.Visible = false
					Storage.Drawings.BulletRedirection.outside_circle.Visible = false
				end
            end
        }),
		FilledFOV = Sections.Combat.BulletRedirectionSettings:Toggle({
            Name = "filled",
            Default = false,
            Pointer = "bulletredirectionfovfilled",
            callback = function(state)
				if library.flags['bulletredirectiondrawfov'] then
                	Storage.Drawings.BulletRedirection.filled_circle.Visible = state
				else
					Storage.Drawings.BulletRedirection.filled_circle.Visible = false
				end
            end
        }),
        FilledFOVTransparency = Sections.Combat.BulletRedirectionSettings:Slider({
            Name = "filled transparency",
            Minimum = 0,
            Maximum = 1,
            Default = 0.5,
            Decimals = 0.000000000000000001,
            Pointer = "bulletredirectionfovfilledtransparency",
            callback = function(state)
                Storage.Drawings.BulletRedirection.filled_circle.Transparency = state
            end
        }),
		Radius = Sections.Combat.BulletRedirectionSettings:Slider({
            Name = "radius",
            Minimum = 1,
            Maximum = 360,
            Default = 35,
            Decimals = 0.000000000000000001,
            Pointer = "bulletredirectionfovradius",
            callback = function(state)
                Storage.Drawings.BulletRedirection.filled_circle.Radius = state - 1.5
				Storage.Drawings.BulletRedirection.main_circle.Radius = state
				Storage.Drawings.BulletRedirection.inside_circle.Radius = state - 1.5
				Storage.Drawings.BulletRedirection.outside_circle.Radius = state + 1.5
            end
        }),
		Snapline = Sections.Combat.BulletRedirectionSettings:Toggle({
            Name = "snapline",
            Default = false,
            Pointer = "bulletredirectiontargetsnapline",
            callback = function(state)
                print(state)
            end
        }),
		SnaplineOrigin = Sections.Combat.BulletRedirectionSettings:Dropdown({
            Name = "origin",
            Options = {"Mouse", "Top", "Bottom", "Middle"},
            Default = "Mouse",
            Pointer = "bulletredirectionsnaplineorigin",
            callback = function(state)
                print(state)
            end
        })
	},
    AimAssistSettings = {
		UseFOV = Sections.Combat.AimAssistSettings:Toggle({
            Name = "use fov",
            Default = false,
            Pointer = "aimassistusefov",
            callback = function(state)
                print(state)
            end
        }),
		DrawFOV = Sections.Combat.AimAssistSettings:Toggle({
            Name = "draw fov",
            Default = false,
            Pointer = "aimassistdrawfov",
            callback = function(state)
                main_circle.Visible = state
				if library.flags['aimassistfovoutline'] then
					Storage.Drawings.AimAssist.inside_circle.Visible = state
					Storage.Drawings.AimAssist.outside_circle.Visible = state
				end
                if library.flags['aimassistfovfilled'] then
                    Storage.Drawings.AimAssist.filled_circle.Visible = state
                end
            end
        }),
        OutlineFOV = Sections.Combat.AimAssistSettings:Toggle({
            Name = "outline",
            Default = false,
            Pointer = "aimassistfovoutline",
            callback = function(state)
				if library.flags['aimassistdrawfov'] then
                	Storage.Drawings.AimAssist.inside_circle.Visible = state
					Storage.Drawings.AimAssist.outside_circle.Visible = state
				else
					Storage.Drawings.AimAssist.inside_circle.Visible = false
					Storage.Drawings.AimAssist.outside_circle.Visible = false
				end
            end
        }),
		FilledFOV = Sections.Combat.AimAssistSettings:Toggle({
            Name = "filled",
            Default = false,
            Pointer = "aimassistfovfilled",
            callback = function(state)
				if library.flags['aimassistdrawfov'] then
                	Storage.Drawings.AimAssist.filled_circle.Visible = state
				else
					Storage.Drawings.AimAssist.filled_circle.Visible = false
				end
            end
        }),
        FilledFOVTransparency = Sections.Combat.AimAssistSettings:Slider({
            Name = "filled transparency",
            Minimum = 0,
            Maximum = 1,
            Default = 0.5,
            Decimals = 0.000000000000000001,
            Pointer = "aimassistfovfilledtransparency",
            callback = function(state)
                Storage.Drawings.AimAssist.filled_circle.Transparency = state
            end
        }),
		Radius = Sections.Combat.AimAssistSettings:Slider({
            Name = "radius",
            Minimum = 1,
            Maximum = 360,
            Default = 35,
            Decimals = 0.000000000000000001,
            Pointer = "aimassistfovradius",
            callback = function(state)
                Storage.Drawings.AimAssist.filled_circle.Radius = state - 1.5
				Storage.Drawings.AimAssist.main_circle.Radius = state
				Storage.Drawings.AimAssist.inside_circle.Radius = state - 1.5
				Storage.Drawings.AimAssist.outside_circle.Radius = state + 1.5
            end
        }),
    }
}

Combat.BulletRedirectionSettings.DrawFOV:Colorpicker({
	Name = "fov color",
	Info = "fov color",
	Alpha = 0.5,
	Default = Color3.fromRGB(255, 255, 255),
	Pointer = "bulletredirectionfovcolor",
	callback = function(state)
		Storage.Drawings.BulletRedirection.main_circle.Color = state
	end
})

Combat.BulletRedirectionSettings.FilledFOV:Colorpicker({
	Name = "filled fov color",
	Info = "filled fov color",
	Alpha = 0.5,
	Default = Color3.fromRGB(133, 87, 242),
	Pointer = "bulletredirectionfilledfovcolor",
	callback = function(state)
		Storage.Drawings.BulletRedirection.filled_circle.Color = state
	end
})

Combat.BulletRedirectionSettings.Snapline:Colorpicker({
	Name = "snapline color",
	Info = "snapline color",
	Alpha = 0.5,
	Default = Color3.fromRGB(255, 255, 255),
	Pointer = "bulletredirectiontargetsnaplinecolor",
	callback = function(state)
		print(state)
	end
})

Combat.AimAssistSettings.DrawFOV:Colorpicker({
	Name = "fov color",
	Info = "fov color",
	Alpha = 0.5,
	Default = Color3.fromRGB(255, 255, 255),
	Pointer = "aimassistfovcolor",
	callback = function(state)
		Storage.Drawings.AimAssist.main_circle.Color = state
	end
})

Combat.AimAssistSettings.FilledFOV:Colorpicker({
	Name = "filled fov color",
	Info = "filled fov color",
	Alpha = 0.5,
	Default = Color3.fromRGB(133, 87, 242),
	Pointer = "aimassistfilledfovcolor",
	callback = function(state)
		Storage.Drawings.AimAssist.filled_circle.Color = state
	end
})

local Visuals = {
	Players = {
		Enabled = Sections.Visuals.Players:Toggle({
            Name = "enabled",
            Default = false,
            Pointer = "esp",
            callback = function(state)
                esp.enabled = state
            end
        }),
        Whitelist = Sections.Visuals.Players:Toggle({
            Name = "whitelist",
            Default = false,
            Pointer = "espwhitelist",
            callback = function(state)
                esp.whitelist = state
                if state then
                    for i, plr in next, Players:GetPlayers() do
                        esp:remove(plr)
                    end
                else
                    for i, plr in next, Players:GetPlayers() do
                        esp:remove(plr)
                    end
                    task.wait()
                    for i, plr in next, Players:GetPlayers() do
                        esp:add(plr)
                    end
                end
            end
        }),
        WhitelistBind = Sections.Combat.Targetting:Keybind({
            Name = "whitelist bind",
            Default = Enum.KeyCode.T,
            Blacklist = { Enum.UserInputType.MouseButton1 },
            Flag = "forcetargetbind",
            Callback = function(key, fromsetting)
                if not fromsetting then
                    if library.flags['espwhitelist'] then
                        print('added player to esp whitelist!')
                    end
                end
            end
        }),
        FontSize = Sections.Visuals.Players:Slider({
            Name = "text size",
            Minimum = 1,
            Maximum = 50,
            Default = 13,
            Decimals = 0.000000000000000001,
            Pointer = "espfontsize",
            callback = function(state)
                esp.textsize = state
            end
        }),
        LimitDistance = Sections.Visuals.Players:Toggle({
            Name = "limit distance",
            Default = false,
            Pointer = "esplimitdistance",
            callback = function(state)
                esp.limitdistance = state
            end
        }),
        LimitedDistance = Sections.Visuals.Players:Slider({
            Name = "limited distance",
            Minimum = 0,
            Maximum = 5000,
            Default = 1200,
            Decimals = 0.000000000000000001,
            Pointer = "esplimiteddistance",
            callback = function(state)
                esp.maxdistance = state
            end
        }),
        FadeFactor = Sections.Visuals.Players:Slider({
            Name = "fade factor",
            Minimum = 0,
            Maximum = 100,
            Default = 20,
            Decimals = 0.000000000000000001,
            Pointer = "espfadefactor",
            callback = function(state)
                esp.fadefactor = state
            end
        }),
        Outlines = Sections.Visuals.Players:Toggle({
            Name = "outlines",
            Default = false,
            Pointer = "espoutlines",
            callback = function(state)
                esp.outlines = state
            end
        }),
		Boxes = Sections.Visuals.Players:Toggle({
            Name = "boxes",
            Default = false,
            Pointer = "espboxes",
            callback = function(state)
                esp.team_boxes[1] = state
            end
        }),
		HealthBar = Sections.Visuals.Players:Toggle({
            Name = "health bar",
            Default = false,
            Pointer = "esphealthbar",
            callback = function(state)
                esp.team_healthbar[1] = state
            end
        }),
        HealthText = Sections.Visuals.Players:Toggle({
            Name = "kevlar bar",
            Default = false,
            Pointer = "espkevlarbar",
            callback = function(state)
                esp.team_kevlarbar[1] = state
            end
        }),
        Names = Sections.Visuals.Players:Toggle({
            Name = "names",
            Default = false,
            Pointer = "espnames",
            callback = function(state)
                esp.team_names[1] = state
            end
        }),
        Distance = Sections.Visuals.Players:Toggle({
            Name = "distance",
            Default = false,
            Pointer = "espdistance",
            callback = function(state)
                esp.team_distance = state
            end
        }),
        Weapons = Sections.Visuals.Players:Toggle({
            Name = "weapons",
            Default = false,
            Pointer = "espweapons",
            callback = function(state)
                esp.team_weapon[1] = state
            end
        }),
        Chams = Sections.Visuals.Players:Toggle({
            Name = "chams",
            Default = false,
            Pointer = "espchams",
            callback = function(state)
                esp.team_chams[1] = state
            end
        }),
        ArrowsRadius = Sections.Visuals.Players:Slider({
            Name = "outline transparency",
            Minimum = 0,
            Maximum = 1,
            Default = 0.7,
            Decimals = 0.000000000000000001,
            Pointer = "espchamsoutlinetransparency",
            callback = function(state)
                esp.team_chams[5] = state
            end
        }),
        ArrowsRadius = Sections.Visuals.Players:Slider({
            Name = "filled transparency",
            Minimum = 0,
            Maximum = 1,
            Default = 0.7,
            Decimals = 0.000000000000000001,
            Pointer = "espchamsfilledtransparency",
            callback = function(state)
                esp.team_chams[4] = state
            end
        }),
        Arrows = Sections.Visuals.Players:Toggle({
            Name = "arrows",
            Default = false,
            Pointer = "esparrows",
            callback = function(state)
                esp.team_arrow[1] = state
            end
        }),
        Arrows = Sections.Visuals.Players:Toggle({
            Name = "arrow info",
            Default = false,
            Pointer = "esparrowsinfo",
            callback = function(state)
                esp.arrowinfo = state
            end
        }),
        ArrowsRadius = Sections.Visuals.Players:Slider({
            Name = "arrow size",
            Minimum = 1,
            Maximum = 100,
            Default = 20,
            Decimals = 0.000000000000000001,
            Pointer = "esparrowsradius",
            callback = function(state)
                esp.arrowsize = state
            end
        }),
        ArrowsRadius = Sections.Visuals.Players:Slider({
            Name = "arrow radius",
            Minimum = 1,
            Maximum = 1000,
            Default = 500,
            Decimals = 0.000000000000000001,
            Pointer = "esparrowsradius",
            callback = function(state)
                esp.arrowradius = state
            end
        })
	}
}

Visuals.Players.Boxes:Colorpicker({
	Name = "boxes color",
	Info = "boxes color",
	Alpha = 0.5,
	Default = Color3.fromRGB(255, 255, 255),
	Pointer = "espboxescolor",
	callback = function(state)
		esp.team_boxes[2] = state
	end
})

Visuals.Players.Names:Colorpicker({
	Name = "names color",
	Info = "names color",
	Alpha = 0.5,
	Default = Color3.fromRGB(255, 255, 255),
	Pointer = "espnamescolor",
	callback = function(state)
		esp.team_names[2] = state
	end
})

Visuals.Players.Weapons:Colorpicker({
	Name = "weapons color",
	Info = "weapons color",
	Alpha = 0.5,
	Default = Color3.fromRGB(255, 255, 255),
	Pointer = "espweaponscolor",
	callback = function(state)
		esp.team_weapon[2] = state
	end
})

Visuals.Players.Chams:Colorpicker({
	Name = "chams color",
	Info = "chams color",
	Alpha = 0.5,
	Default = Color3.fromRGB(255, 255, 255),
	Pointer = "chamscolor",
	callback = function(state)
		esp.team_chams[3] = state
        esp.team_chams[2] = state
	end
})

Visuals.Players.Arrows:Colorpicker({
	Name = "arrows color",
	Info = "arrows color",
	Alpha = 0.5,
	Default = Color3.fromRGB(255, 255, 255),
	Pointer = "esparrowscolor",
	callback = function(state)
		esp.team_arrow[2] = state
	end
})

local Config = {
    Utilities = {
        ToggleUIBind = Sections.Config.Utilities:Keybind({
            Name = "toggle ui",
            Default = Enum.KeyCode.Insert,
            Blacklist = { Enum.UserInputType.MouseButton1 },
            Flag = "toggleuibind",
            Callback = function(key, fromsetting)
                if not fromsetting then
                    library:Toggle()
                end
            end
        }),--[[
        Watermark = Sections.Config.Utilities:Toggle({
            Name = "show watermark",
            Default = false,
            Pointer = "showwatermark",
            callback = function(state)
                print(state)
            end
        }),]]
    },
    Configurations = {
        ConfigDropdown = Sections.Config.Configs:Dropdown({
            Name = "configs",
            Options = library:ListConfigs(),
            Pointer = 'currentconfig',
            Callback = function(option)
                currentconfig = option
            end
        }),
        ConfigName = Sections.Config.Configs:Box({
            Name = "config name",
            Pointer = 'configname',
            Callback = function(state)
                print(state)
            end
        })
    }
}

Sections.Config.Configs:Button({
    Name = "Save",
    Callback = function()
        library:SaveConfig(library.flags['configname'])
        Config.Configurations.ConfigDropdown:Refresh(library:ListConfigs())
    end
})

Sections.Config.Configs:Button({
    Name = "Load",
    Callback = function()
        library:LoadConfig(library.flags['currentconfig'])
    end
})

Sections.Config.Configs:Button({
    Name = "Delete",
    Callback = function()
        library:DeleteConfig(library.flags['currentconfig'])
        Config.Configurations.ConfigDropdown:Refresh(library:ListConfigs())
    end
})

library:Initialize()

function aim()
    if not Storage.Targets.AimAssistTarget then return end

    local char = Storage.Targets.AimAssistTarget.Character
    local prediction;
    if library.flags['aimassistprediction'] then
        if library.flags['aimassistautoprediction'] then
            prediction = 
        else
            prediction = library.flags['aimassistpredictionvalue']
        end
    else
        prediction = 0
    end
    local shakeoffset;
    if library.flags['aimassistshake'] then
        if library.flags['aimassistshakerandomization'] then
            shakeoffset = Vector3.new(math.random()*(library.flags['aimassistshakex']-1) + 1, math.random()*(library.flags['aimassistshakex']-1) + 1, 0)
        else
            shakeoffset = Vector3.new(library.flags['aimassistshakex'], library.flags['aimassistshakey'], 0)
        end
    else
        shakeoffset = Vector3.zero
    end
    local aimspeed;
    if library.flags['aimassistairmode'] and char:FindFirstChildWhichIsA('Humanoid'):GetState() == Enum.HumanoidStateType.Freefall then
        aimspeed = library.flags['aimassistsmoothing'] * library.flags['aimassistsensitivity'] * library.flags['aimassistairmodesmoothing']
    else
        aimspeed = library.flags['aimassistsmoothing'] * library.flags['aimassistsensitivity']
    end
    if library.flags['aimassistunlockondeath'] then
        if char.BodyEffects:FindFirstChild('K.O').Value or char:FindFirstChild('GRABBING_CONSTRAINT') then
            Storage.Targets.AimAssistTarget = nil
        end
    end
    if library.flags['aimassistunlockonlocaldeath'] then
        if LocalPlayer.Character.BodyEffects:FindFirstChild('K.O').Value or LocalPlayer.Character:FindFirstChild('GRABBING_CONSTRAINT') then
            Storage.Targets.AimAssistTarget = nil
        end
    end

    if library.flags['aimassistmethod'] == 'Camera' then

    else
        -- doesnt work on uwp
    end
end

game:GetService('RunService').PostSimulation:Connect(function()
	local UserInputService = game:GetService('UserInputService')
	local MousePosition = UserInputService:GetMouseLocation()

    if library.flags['aimassistautoprediction'] or library.flags['bulletredirectionautoprediction'] then
        local ping = math.floor(game.Stats.Network.ServerStatsItem["Data Ping"]:GetValue())

        if ping < 130 then
            Storage.Settings.AutoPredictionValue = ping / 1000 + 0.037
        else
            Storage.Settings.AutoPredictionValue = ping / 1000 + 0.033
        end
    end

	main_circle.Position = MousePosition
	outside_circle.Position = MousePosition
	inside_circle.Position = MousePosition
	filled_circle.Position = MousePosition
end)
--[[
local parts = {
    "Head",
    "UpperTorso",
    "RightUpperArm",
    "RightLowerArm",
    "RightUpperArm",
    "LeftUpperArm",
    "LeftLowerArm",
    "LeftFoot",
    "RightFoot",
    "LowerTorso",
    "LeftHand",
    "RightHand",
    "RightUpperLeg",
    "LeftUpperLeg",
    "LeftLowerLeg",
    "RightLowerLeg"
}


local VisualsExtra = {
    WorldVisuals = {
        MapLightingEnabled = false,
        MapBrightness = 0.6,
        MapContrast = 0.2,
        MapTintColor = Color3.fromRGB(0, 0, 153)
    },
    WeaponEffects = {
        Enabled = false,
        Color = Color3.fromRGB(255, 0, 0),
        Material = "ForceField"
    },
    ClientVisuals = {
        SelfChams = false,
        SelfChamsMaterial = "ForceField",
        SelfChamsColor = Color3.fromRGB(255, 0, 0),
        BaseSkin = "Plastic"
    }
}

local ConfigurationTab = {
    Configs = {

    },
    UIPreferances = {

    }
}

local Toggles = {
    TargetAim = {

        MainToggle = Sections.Aiming.TargetAim.Main:Keybind(
            {
            Name = "enabled",
            Callback = function(key) end,
            Default = key,
            Pointer = "1",
            Mode = "Toggle",
            toggleflag = "1.1",
            togglecallback = function(state)
                AimingSettings.TargetAim.Enabled = state
            end
        }
        ),

        HitboxesToggle = Sections.Aiming.TargetAim.Main:Dropdown(
            {
            Name = "hitboxes",
            Options = {"Head", "UpperTorso", "RightUpperArm", "RightLowerArm", "RightUpperArm", "LeftUpperArm", "LeftLowerArm", "LeftFoot", "RightFoot", "LowerTorso", "LeftHand", "RightHand", "RightUpperLeg", "LeftUpperLeg", "LeftLowerLeg", "RightLowerLeg"},
            Default = "Head",
            Pointer = "2",
            callback = function(state)
                AimingSettings.TargetAim.Hitboxes = state
            end
        }
        ),


        UseNearestDistance = Sections.Aiming.TargetAim.Main:Toggle(
            {
            Name = "Distance Based",
            Default = false,
            Pointer = "3",
            callback = function(state)
                AimingSettings.TargetAim.UseNearestDistance = state
            end
        }
        ),
        CrewCheckToggle = Sections.Aiming.TargetAim.Main:Toggle(
            {
            Name = "Prioritise Team",
            Default = false,
            Pointer = "4",
            callback = function(state)
                AimingSettings.TargetAim.CrewCheck = state
            end
        }
        ),

        WallCheckToggle = Sections.Aiming.TargetAim.Main:Toggle(
            {
            Name = "Visibility Check",
            Default = false,
            Pointer = "5",
            callback = function(state)
                AimingSettings.TargetAim.WallCheck = state
            end
        }
        ),


        ShowFOVToggle = Sections.Aiming.TargetAim.Settings:Toggle(
            {
            Name = "Draw Fov",
            Default = false,
            Pointer = "6",
            callback = function(state)
                AimingSettings.TargetAim.ShowFOV = state
            end
        }
        ),

        FOVSlider = Sections.Aiming.TargetAim.Settings:Slider(
            {
            Name = "Bullet Radius Size",
            Minimum = 1,
            Maximum = 10,
            Default = 1,
            Decimals = 0.1,
            Pointer = "7",
            callback = function(state)
                AimingSettings.TargetAim.FOV = state ^ 3
            end
        }
        )

    },
    Aimbot = {
        EnableTog = Sections.Aiming.Aimbot.Main:Toggle(
            {
            Name = "Enabled",
            Default = false,
            Pointer = "8",
            callback = function(e)
                AimingSettings.Aimbot.CameraMode = e
            end
        }
        ),
        SmoothingToggle = Sections.Aiming.Aimbot.Main:Toggle(
            {
            Name = "Smoothing",
            Default = false,
            Pointer = "9",
            callback = function(state)
                AimingSettings.Aimbot.Smoothing = state
            end
        }
        ),

        HitboxesDropdown = Sections.Aiming.Aimbot.Main:Dropdown(
            {
            Name = "Hitbox",
            Options = { "Head", "UpperTorso", "HumanoidRootPart" },
            Default = "Head",
            Pointer = "10",
            callback = function(state)
                AimingSettings.Aimbot.Hitbox = state
            end
        }
        ),

        TeamCheckToggle = Sections.Aiming.Aimbot.Main:Toggle(
            {
            Name = "Visibility Check",
            Default = false,
            Pointer = "11",
            callback = function()
            end
        }
        ),


        Revaluation = Sections.Aiming.Aimbot.Main:Toggle(
            {
            Name = "Revaluate Hitspand",
            Default = false,
            Pointer = "12",
            callback = function(state)
                AimingSettings.Aimbot.HitAirshots = state
            end
        }
        ),



        PingDropDown = Sections.Aiming.Aimbot.Settings:Dropdown(
            {
            Name = "Aiming Type",
            Options = { "Ping Based", "Custom" },
            Default = "Ping Based",
            Pointer = "13",
            callback = function(state)
                AimingSettings.Aimbot.AutoPredct = state
            end
        }
        ),
        TypeDropdown = Sections.Aiming.Aimbot.Settings:Dropdown(
            {
            Name = "Aiming Tracing",
            Options = { "Camera", "nil" },
            Default = "nil",
            Pointer = "14",
            callback = function(state)

            end
        }
        ),

        SmoothingSlider = Sections.Aiming.Aimbot.Settings:Slider(
            {
            Name = "Smoothing Amount",
            Minimum = 1,
            Maximum = 10,
            Default = 10,
            Decimals = 0.000000000000000001,
            Pointer = "15",
            callback = function(state)
                AimingSettings.Aimbot.Smoothness = state / 50
            end
        }
        ),
        PredictionAmount = Sections.Aiming.Aimbot.Settings:Slider(
            {
            Name = "Prediction Amount",
            Minimum = 1,
            Maximum = 10,
            Default = 10,
            Decimals = 0.000000000000000001,
            Pointer = "16",
            callback = function(state)
                AimingSettings.Aimbot.Prediction = state / 50
            end
        }
        ),

        RageStuff = {

            AntiAimToggle = Sections.RageSector.AntiAim:Toggle(
                {
                Name = "Enabled",
                Default = false,
                Pointer = "17",
                callback = function(state)
                    RageSettings.AntiAim.Enabled = state
                end
            }
            ),
            DesyncToggle = Sections.RageSector.AntiAim:Toggle(
                {
                Name = "Confusion",
                Default = false,
                Pointer = "18",
                callback = function(state)
                    RageSettings.AntiAim.VelocityBreaker = state
                end
            }
            ),
            DesyncVelocitySlider = Sections.RageSector.AntiAim:Slider(
                {
                Name = "Velocity Speed",
                Minimum = 1,
                Maximum = 500,
                Default = 10,
                Decimals = 0.000000000000001,
                Pointer = "19",
                callback = function(state)
                    RageSettings.AntiAim.VBV = state
                end
            }
            ),
            DesyncFrameSlider = Sections.RageSector.AntiAim:Slider(
                {
                Name = "Spin Speed",
                Minimum = 1,
                Maximum = 100,
                Default = 10,
                Decimals = 0.000000000000001,
                Pointer = "20",
                callback = function(state)
                    RageSettings.AntiAim.VBF = state
                end
            }
            ),
            AntiHitToggle = Sections.RageSector.AntiHit:Toggle(
                {
                Name = "Enabled",
                Default = false,
                Pointer = "21",
                callback = function(state)
                    RageSettings.LegitAntiHit.Enabled = state
                end
            }
            ),
            AntiHitSlider = Sections.RageSector.AntiHit:Slider(
                {
                Name = "Multiplier",
                Minimum = 1,
                Maximum = 10,
                Default = 1,
                Decimals = 0.000000000000001,
                Pointer = "22",
                callback = function(state)
                    RageSettings.LegitAntiHit.Multiplier = state / 10
                end
            }
            )
        },

        FakeLagShit = {
            FakeLagT = Sections.RageSector.FakeLag:Toggle(
                {
                Name = "Enabled",
                Default = false,
                Pointer = "23",
                callback = function(state)

                end
            }
            ),


            FakeLagSlid = Sections.RageSector.FakeLag:Slider(
                {
                Name = "Multiplier",
                Minimum = 1,
                Maximum = 10,
                Default = 1,
                Decimals = 0.000000000000001,
                Pointer = "24",
                callback = function(state)
                    RageSettings.FakeLag.Multiplier = state / 30
                end
            }
            ),

            FakeLagBodyCham = Sections.RageSector.FakeLag:Toggle(
                {
                Name = "Body Cham",
                Default = false,
                Pointer = "25",
                callback = function(state)
                    fakelag = state
                end
            }
            ),

        },
    },

    MiscStuff1 = {
        FlyToggle = Sections.MiscSector.Fly:Toggle(
            {
            Name = "Enabled",
            Default = false,
            Pointer = "26",
            callback = function(state)
                MiscSettings.Fly.Enabled = state
            end
        }
        ),
        FlyHightSlider = Sections.MiscSector.Fly:Slider(
            {
            Name = "Height",
            Minimum = 1,
            Maximum = 100,
            Default = 10,
            Decimals = 0.000000000000001,
            Pointer = "27",
            callback = function(state)
                MiscSettings.Fly.Height = state
            end
        }
        ),
        FlyAmount = Sections.MiscSector.Fly:Slider(
            {
            Name = "Multiplier",
            Minimum = 1,
            Maximum = 10,
            Default = 5,
            Decimals = 0.000000000000001,
            Pointer = "28",
            callback = function(state)
                MiscSettings.Fly.Amount = state
            end
        }
        )

    },


    MiscStuff2 = {
        NoJumpCdToggle = Sections.MiscSector.CharMain:Toggle(
            {
            Name = "Blacklisted",
            Default = false,
            Pointer = "29",
            callback = function(state)
                MiscSettings.NoJumpCd.Enabled = state
                MiscSettings.NoSlowdown.Enabled = state
            end
        }
        ),
        CooldownDropdown = Sections.MiscSector.CharMain:Dropdown(
            {
            Name = "Type",
            Options = { "Jump", "Slowdown" },
            Default = "Jump",
            Pointer = "30",
            callback = function()
            end
        }
        ),
    },

    MovementShit = {
        SpeedToggle = Sections.MiscSector.SpeedMain:Toggle(
            {
            Name = "Enabled",
            Default = false,
            Pointer = "31",
            callback = function(state)
                MiscSettings.Speed.Enabled = state
            end
        }
        ),

        BhopToggle = Sections.MiscSector.SpeedMain:Toggle(
            {
            Name = "Bunny Hop",
            Default = false,
            Pointer = "32",
            callback = function(state)
                MiscSettings.Speed.BHop = state
            end
        }
        ),
        SpeedMultipler = Sections.MiscSector.SpeedMain:Slider(
            {
            Name = "Multiplier",
            Minimum = 1,
            Maximum = 10,
            Default = 1,
            Decimals = 0.000000000000001,
            Pointer = "32",
            callback = function(state)
                MiscSettings.Speed.Amount = state
            end
        }
        ),
        TrashTalk = Sections.MiscSector.Fun:Toggle(
            {
            Name = "Enabled",
            Default = false,
            Pointer = "33",
            callback = function(state)
                MiscSettings.TrashTalk.Enabled = state
            end
        }
        ),
        TrashTalkDropdown = Sections.MiscSector.Fun:Dropdown(
            {
            Name = "Type",
            Options = { "Main" },
            Default = "Main",
            Pointer = "34",
            callback = function(state)
            end
        }
        )
    }
}

local StrafeSection = {
    TargetStrafe = Sections.RageSector.TargetStrafe:Toggle(
        {
        Name = "Enabled",
        Default = false,
        Pointer = "35",
        callback = function(state)
            RageSettings.TargetStrafe.Enabled = state
        end
    }
    ),



    StrafeSlider = Sections.RageSector.TargetStrafe:Slider(
        {
        Name = "Range",
        Minimum = 1,
        Maximum = 100,
        Default = 50,
        Decimals = 0.000000000000001,
        Pointer = "36",
        callback = function(state)
            RageSettings.TargetStrafe.Distance = state
        end
    }
    ),

    SpeedStrafe = Sections.RageSector.TargetStrafe:Slider(
        {
        Name = "Speed",
        Minimum = 1,
        Maximum = 100,
        Default = 50,
        Decimals = 0.000000000000001,
        Pointer = "37",
        callback = function(state)
            RageSettings.TargetStrafe.Speed = state / 50
        end
    }
    ),

    StrafeRage = Sections.RageSector.TargetStrafe:Toggle(
        {
        Name = "Rage Bot",
        Default = false,
        Pointer = "37",
        callback = function(state)
            RageSettings.TargetStrafe.AntiAimMode = state
        end
    }
    ),


StrafeMode = Sections.RageSector.TargetStrafe:Dropdown({
    Name = "Type",
    Options = { "Flinger", "Default" },
    Default = "Default",
    Pointer = "38",
    callback = function(state)
        RageSettings.TargetStrafe.AntiAimType = state
    end
})}


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- mouse toggles --

local MousePositionToggles = MouseEnabled = Sections.Aiming.MouseStuff:Toggle({
    Name = "Enabled",
    Default = false,
    Pointer = "39",
    callback = function(state)
        AimingSettings.MousePosSector.Enabled = state
    end
})


MouseSizeSlider = Sections.Aiming.MouseStuff:Slider({
    Name = "Pos Radius",
    Minimum = 1,
    Maximum = 50,
    Default = 1,
    Decimals = 0.1,
    Pointer = "40",
    callback = function(state)
        AimingSettings.MousePosSector.Size = state
    end
})

StrafeSection.TargetStrafe:Colorpicker({
    Name = "Mouse Color",
    Info = "Mouse Color",
    Alpha = 0.5,
    Default = Color3.fromRGB(133, 87, 242),
    Pointer = "42",
    callback = function(shit)
        Circle.Color = shit
    end
})

MousePositionToggles.MouseEnabled:Colorpicker({
    Name = "Mouse Color",
    Info = "Mouse Color",
    Alpha = 0.5,
    Default = Color3.fromRGB(133, 87, 242),
    Pointer = "43",
    callback = function(shit)
        AimingSettings.MousePosSector.DOTColor = shit
    end
})

local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = 180
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = AimingSettings.TargetAim.FovTransparency
fov_circle.Color = Color3.fromRGB(54, 57, 241)

local outline = Drawing.new("Circle")
outline.Thickness = 0.3
outline.NumSides = 100
outline.Radius = fov_circle.Radius
outline.Filled = false
outline.Visible = false
outline.ZIndex = 999
outline.Color = Color3.fromRGB(1, 1, 1)

local EspVisuals = {

    BoxesToggle = Sections.Visuals.MainVisuals:Toggle(
        {
        Name = "Boxes",
        Default = false,
        Pointer = "44",
        callback = function(bi)
        end
    }
    ),

    NameToggle = Sections.Visuals.MainVisuals:Toggle(
        {
        Name = "Names",
        Default = false,
        Pointer = "45",
        callback = function(bi)
        end
    }
    ),
    TracersToggle = Sections.Visuals.MainVisuals:Toggle(
        {
        Name = "Tracers",
        Default = false,
        Pointer = "46",
        callback = function(bi)
        end
    }
    ),
    SkelotonToggle = Sections.Visuals.MainVisuals:Toggle(
        {
        Name = "Skeletons",
        Default = false,
        Pointer = "47",
        callback = function(bi)
        end
    }
    ),



    DistanceTog = Sections.Visuals.MainVisuals:Toggle(
        {
        Name = "Distance",
        Default = false,
        Pointer = "48",
        callback = function(bi)

        end
    }
    ),

    HealthInfo = Sections.Visuals.MainVisuals:Toggle(
        {
        Name = "Health Info",
        Default = false,
        Pointer = "49",
        callback = function(bi)

        end
    }
    ),

    GunInfo = Sections.Visuals.MainVisuals:Toggle(
        {
        Name = "Weapon Info",
        Default = false,
        Pointer = "50",
        callback = function(bi)
        end
    }
    ),




    ChamsTog = Sections.Visuals.PlayerChams:Toggle(
        {
        Name = "Body Cham",
        Default = false,
        Pointer = "51",
        callback = function(state)
            VisualsExtra.ClientVisuals.SelfChams = state
        end
    }
    ),

    ChamDrop = Sections.Visuals.PlayerChams:Dropdown(
        {
        Name = "Body Material",
        Options = { "ForceField", "Glass" },
        Default = "ForceField",
        Pointer = "52",
        callback = function(state)
            VisualsExtra.ClientVisuals.SelfChamsMaterial = state
        end
    }
    ),
    GunTog = Sections.Visuals.PlayerChams:Toggle(
        {
        Name = "Gun Cham",
        Default = false,
        Pointer = "53",
        callback = function(state)
            VisualsExtra.WeaponEffects.Enabled = state
        end
    }
    ),
    GunDrop = Sections.Visuals.PlayerChams:Dropdown(
        {
        Name = "Gun Material",
        Options = { "ForceField", "Glass" },
        Default = "ForceField",
        Pointer = "54",
        callback = function(state)
            VisualsExtra.WeaponEffects.Material = state
        end
    }
    ),

    BulletTracersToggle = Sections.Visuals.BulletTracers:Toggle(
        {
        Name = "Enabled",
        Default = false,
        Pointer = "55",
        callback = function(bi)
            BulletTracers = bi
        end
    }
    ),



    MapLightingToggle = Sections.Visuals.WorldVisuals:Toggle(
        {
        Name = "Map Lighting",
        Default = false,
        Pointer = "56",
        callback = function(bi)
            VisualsExtra.WorldVisuals.MapLightingEnabled = bi
        end
    }
    ), -- add more shit soon
    MapBrightness = Sections.Visuals.WorldVisuals:Slider(
        {
        Name = "Map Brightness",
        Minimum = 0,
        Maximum = 100,
        Default = 1,

        Decimals = 0.1,
        Pointer = "57",
        callback = function(E)
            VisualsExtra.WorldVisuals.MapBrightness = E / 50
        end
    }
    ),
    MapContrast = Sections.Visuals.WorldVisuals:Slider(
        {
        Name = "Map Contrast",
        Minimum = 0,
        Maximum = 100,
        Default = 1,

        Decimals = 0.1,
        Pointer = "58",
        callback = function(E)
            VisualsExtra.WorldVisuals.MapContrast = E / 50
        end
    }
    )



}
EspVisuals.BulletTracersToggle:Colorpicker(
    {
    Name = "Bullet Tracers",
    Info = "Bullet Tracers",
    Alpha = 0.5,
    Default = Color3.fromRGB(255, 0, 0),
    Pointer = "59",
    callback = function(bi)
        bullet_tracer_color = bi
    end
}
)


EspVisuals.MapLightingToggle:Colorpicker(
    {
    Name = "Lighting Color",
    Info = "World Color",
    Alpha = 0.5,
    Default = Color3.fromRGB(255, 255, 255),
    Pointer = "60",
    callback = function(shit)
        VisualsExtra.WorldVisuals.MapTintColor = shit
    end
}
)

EspVisuals.BoxesToggle:Colorpicker(
    {
    Name = "Esp Color",
    Info = "Esp Color",
    Alpha = 0.5,
    Default = Color3.fromRGB(137, 207, 240),
    Pointer = "61",
    callback = function(shit)
        ESPColor = shit

    end
}
)



EspVisuals.ChamsTog:Colorpicker(
    {
    Name = "Self Chams Color",
    Info = "Self Chams Color",
    Alpha = 0.5,
    Default = Color3.fromRGB(133, 87, 242),
    Pointer = "62",
    callback = function(bi)
        VisualsExtra.ClientVisuals.SelfChamsColor = bi
    end
}
)

EspVisuals.GunTog:Colorpicker(
    {
    Name = "Gun Color",
    Info = "Gun Color",
    Alpha = 0.5,
    Default = Color3.fromRGB(255, 0, 0),
    Pointer = "63",
    callback = function(bi)
        VisualsExtra.WeaponEffects.Color = bi
    end
}
)


local watermark = library:Watermark {}

task.spawn(function()
    local frames = 0

    game:GetService "RunService".RenderStepped:Connect(function()
        frames = frames + 1
    end)

    watermark:Update { "specter.lua", ScriptProperties.UserPanel.Status, frames .. " FPS", string.format("%s:%s %s", tonumber(os.date("%I")), os.date("%M"), os.date("%p")) }

    while task.wait(1) do
        watermark:Update { "specter.lua", ScriptProperties.UserPanel.Status, frames .. " FPS", string.format("%s:%s %s", tonumber(os.date("%I")), os.date("%M"), os.date("%p")) }
        frames = 0
    end
end)

local currentconfig = ""
local configname = ""

ConfigStuff = {


    configdropdown = Sections.Configuations.Configs:Dropdown { Name = "Main", Options = Library:ListConfigs(), Callback = function(option)
        currentconfig = option
    end },



    Sections.Configuations.Configs:Box { Name = "", Callback = function(text)
        configname = text
    end },

    Sections.Configuations.Configs:Button { Name = "Save", Callback = function()
        Library:SaveConfig(configname)
        ConfigStuff.configdropdown:Refresh(Library:ListConfigs())
    end }
    ,

    Sections.Configuations.Configs:Button { Name = "Load", Callback = function()
        Library:LoadConfig(currentconfig)
    end },
    Sections.Configuations.Configs:Button { Name = "Delete", Callback = function()
        Library:DeleteConfig(currentconfig)
        ConfigStuff.configdropdown:Refresh(Library:ListConfigs())
    end }


}



SettingsSection = {
    UiToggle = Sections.Configuations.ScriptStuff:Keybind { Name = "Keybind", Default = Enum.KeyCode.RightShift, Blacklist = { Enum.UserInputType.MouseButton1 }, Flag = "CurrentBind", Callback = function(key, fromsetting)
        if not fromsetting then
            library:Toggle()
        end
    end },

    WaterMarkToggle = Sections.Configuations.ScriptStuff:Keybind { Name = "Watermark", Default = Enum.KeyCode.RightShift, Blacklist = { Enum.UserInputType.MouseButton1 }, Flag = "CurrentToggle", Callback = function(key, fromsetting)
        if not fromsetting then
            watermark:Toggle()
        end
    end }

}



Library:ChangeAccent(Color3.fromRGB(133, 87, 242))
Library:ChangeOutline { Color3.fromRGB(121, 66, 254), Color3.fromRGB(223, 57, 137) }

Library:Initialize()
]]