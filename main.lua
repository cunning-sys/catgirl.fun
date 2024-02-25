local players = game:GetService('Players')
local localplayer = players.LocalPlayer

local cheat = {functions = {}, connections = {}}

function cheat.functions.getcrewname(plr)
    if plr.DataFolder.Information:FindFirstChild('Crew') and not plr.DataFolder.Information.Crew.Value == '' then
        return game:GetService('GroupService'):GetGroupInfoAsync(plr.DataFolder.Information.Crew.Value).Name
    else
        return 'nil'
    end
end

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cunning-sys/catgirl.fun/main/ui-library.lua'))()
local esp = loadstring(game:HttpGet('https://raw.githubusercontent.com/cunning-sys/catgirl.fun/main/esp.lua'))()

local window = library:Load({
    title = 'catgirl.cc',
    game = 'da hood',
    discord = '9FawWVxcpG',
    playerlist = true,
    playerlistmax = 40
})

library.playerlist:Button({
    name = 'ESP Whitelist',
    callback = function(list, plr)
        if not list:IsTagged(plr, 'ESP Whitelisted') and esp.enabled and esp.whitelist then
            esp:add(plr)
            list:Tag({
                player = plr,
                text = 'ESP Whitelisted',
                color = Color3.fromRGB(0, 255, 0)
            })
        else
            esp:remove(plr)
            list:RemoveTag(plr, 'ESP Whitelisted')
        end
    end
})

library.playerlist:Button({
    name = 'Aim-View',
    callback = function(list, plr)
        if not list:IsTagged(plr, 'Aim-Viewing') then
            list:Tag({
                player = plr,
                text = 'Aim-Viewing',
                color = Color3.fromRGB(0, 255, 0)
            })
        else
            list:RemoveTag(plr, 'Aim-Viewing')
        end
    end
})
library.playerlist:Button({
    name = 'Goto',
    callback = function(list, plr)
        localplayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
    end
})

library.playerlist:Label({name = 'Crew: ', handler = function(plr)
    return cheat.functions.getcrewname(plr)
end})

library.playerlist:Label({name = 'Bounty: ', handler = function(plr)
    return plr.DataFolder.Information.Wanted.Value
end})

local aiming_tab = window:Tab(' aiming')
local bulletredirect_sec = aiming_tab:Section({name = 'bullet-redirection', side = 'Left'})
local targetaim_sec = aiming_tab:Section({name = 'target-aim', side = 'Middle'})
local aimassist_sec = aiming_tab:Section({name = 'aim-assist', side = 'Right'})

local visuals_tab = window:Tab('visuals')
local esp_sec = visuals_tab:Section({name = 'esp', side = 'Left'})

local esp_toggle = esp_sec:Toggle{
    name = 'enabled',
    default = false,
    flag = 'esp_enabled',
    callback = function(value)
        esp.enabled = value
        if value then
            if not esp.whitelist then
                for i, plr in next, players:GetPlayers() do
                    esp:add(plr)
                end
            end
        else
            for i, plr in next, players:GetPlayers() do
                esp:remove(plr)
            end
        end
    end
}

local esp_whitelist_toggle = esp_sec:Toggle{
    name = 'whitelist',
    default = false,
    flag = 'esp_whitelist_enabled',
    callback = function(value)
        esp.whitelist = value;
        if value then
            for i, plr in next, players:GetPlayers() do
                esp:remove(plr)
            end
        else
            for i, plr in next, players:GetPlayers() do
                esp:remove(plr)
            end

            for i, plr in next, players:GetPlayers() do
                library.Playerlist:RemoveTag(plr, 'ESP Whitelisted')
            end

            if esp.enabled then
                for i, plr in next, players:GetPlayers() do
                    esp:add(plr)
                end
            end
        end
    end
}

local esp_font_size = esp_sec:Slider{
    name = "font size",
    default = esp.textsize,
    min = 0,
    max = 25,
    float = 1,
    flag = "esp_font_size",
    callback = function(value)
        esp.textsize = value;
    end
}

local esp_limit_distance = esp_sec:Toggle{
    name = 'limit distance',
    default = false,
    flag = 'esp_limit_distance',
    callback = function(value)
        esp.limitdistance = value;
    end
}

local esp_limited_distance = esp_sec:Slider{
    name = "limited distance",
    default = esp.maxdistance,
    min = 50,
    max = 5000,
    float = 1,
    flag = "esp_limited_distance",
    callback = function(value)
        esp.maxdistance = value;
    end
}

--[[
local esp_fade_factor = esp_sec:Slider{
    name = "fade factor",
    default = esp.fadefactor,
    min = 0,
    max = 100,
    flag = "esp_fade_factor",
    callback = function(value)
        esp.fadefactor = value;
    end
}
]]

local esp_boxes = esp_sec:Toggle{
    name = 'boxes',
    default = false,
    flag = 'esp_boxes',
    callback = function(value)
        esp.team_boxes[1] = value;
    end
}

esp_boxes:Colorpicker{
    default = esp.team_boxes[2],
    flag = 'esp_boxes_color',
    callback = function(value)
        esp.team_boxes[2] = value;
    end
}

local esp_healthbar = esp_sec:Toggle{
    name = 'health bar',
    default = false,
    flag = 'esp_healthbar',
    callback = function(value)
        esp.team_healthbar[1] = value;
    end
}

esp_healthbar:Colorpicker{
    name = 'high health colorpicker',
    default = Color3.fromRGB(0, 255, 0),
    flag = 'esp_healthbar_down_color',
    callback = function(value)
        esp.team_healthbar[3] = value;
    end
}

esp_healthbar:Colorpicker{
    name = 'low health colorpicker',
    default = Color3.fromRGB(0, 255, 0),
    flag = 'esp_healthbar_up_color',
    callback = function(value)
        esp.team_healthbar[2] = value;
    end
}

local esp_kevlarbar = esp_sec:Toggle{
    name = 'kevlar bar',
    default = false,
    flag = 'esp_kevlarbar',
    callback = function(value)
        esp.team_kevlarbar[1] = value;
    end
}

esp_kevlarbar:Colorpicker{
    name = 'low armor colorpicker',
    default = Color3.fromRGB(0, 0, 255),
    flag = 'esp_kevlarbar_down_color',
    callback = function(value)
        esp.team_kevlarbar[3] = value;
    end
}

esp_kevlarbar:Colorpicker{
    name = 'high armor colorpicker',
    default = Color3.fromRGB(0, 0, 255),
    flag = 'esp_kevlarbar_up_color',
    callback = function(value)
        esp.team_kevlarbar[2] = value;
    end
}

local esp_names = esp_sec:Toggle{
    name = 'names',
    default = false,
    flag = 'esp_names',
    callback = function(value)
        esp.team_names[1] = value;
    end
}

esp_names:Colorpicker{
    default = esp.team_names[2],
    flag = 'esp_names_color',
    callback = function(value)
        esp.team_names[2] = value;
    end
}

local esp_distance = esp_sec:Toggle{
    name = 'distance',
    default = false,
    flag = 'esp_distance',
    callback = function(value)
        esp.team_distance = value;
    end
}

local esp_weapon = esp_sec:Toggle{
    name = 'weapon',
    default = false,
    flag = 'esp_weapon',
    callback = function(value)
        esp.team_weapon[1] = value;
    end
}

esp_weapon:Colorpicker{
    default = esp.team_weapon[2],
    flag = 'esp_weapon_color',
    callback = function(value)
        esp.team_weapon[2] = value;
    end
}

local esp_outlines = esp_sec:Toggle{
    name = 'outlines',
    default = false,
    flag = 'esp_outlines',
    callback = function(value)
        esp.outlines = value;
    end
}

local esp_chams = esp_sec:Toggle{
    name = 'chams',
    default = false,
    flag = 'esp_chams',
    callback = function(value)
        esp.team_chams[1] = value;
    end
}

esp_chams:Colorpicker{
    name = 'outline colorpicker',
    default = esp.team_chams[3],
    flag = 'esp_chams_ot_color',
    callback = function(value)
        esp.team_chams[3] = value;
    end
}

esp_chams:Colorpicker{
    name = 'filled colorpicker',
    default = esp.team_chams[2],
    flag = 'esp_chams_ft_color',
    callback = function(value)
        esp.team_chams[2] = value;
    end
}

local esp_chams_ot = esp_sec:Slider{
    name = "outline transparency",
    default = esp.team_chams[5],
    min = 0,
    max = 1,
    float = 0.01,
    flag = "esp_chams_ot",
    callback = function(value)
        esp.team_chams[5] = value;
    end
}

local esp_chams_ft = esp_sec:Slider{
    name = "chams filled transparency",
    default = esp.team_chams[4],
    min = 0,
    max = 1,
    float = 0.01,
    flag = "esp_chams_ft",
    callback = function(value)
        esp.team_chams[4] = value;
    end
}

local esp_arrows = esp_sec:Toggle{
    name = 'arrows',
    default = false,
    flag = 'esp_arrows',
    callback = function(value)
        esp.team_arrow[1] = value;
    end
}

esp_arrows:Colorpicker{
    name = 'arrow colorpicker',
    default = esp.team_arrow[2],
    flag = 'esp_arrow_color',
    callback = function(value)
        esp.team_arrow[2] = value;
    end
}

local esp_arrow_info = esp_sec:Toggle{
    name = 'arrow info',
    default = false,
    flag = 'esp_arrow_info',
    callback = function(value)
        esp.arrowinfo = value;
    end
}

local esp_arrow_size = esp_sec:Slider{
    name = "arrow size",
    default = esp.arrowsize,
    min = 0,
    max = 100,
    flag = "esp_arrow_size",
    callback = function(value)
        esp.arrowsize = value;
    end
}

local esp_arrow_radius = esp_sec:Slider{
    name = "arrow radius",
    default = esp.arrowradius,
    min = 0,
    max = 1000,
    flag = "esp_arrow_radius",
    callback = function(value)
        esp.arrowradius = value;
    end
}

local settings_tab = window:Tab('settings')
local configs_sec = settings_tab:Section({name = "configs", side = 'Left'})

local autoload

local config_dropdown = configs_sec:Dropdown{
    name = "configs",
    default = 'NONE',
    content = library:GetConfigs(),
    flag = "selected_config",
    callback = function(selected)
        if (autoload) then
            local auto_load_config = library:GetAutoLoadConfig();

            if (selected == auto_load_config) then
                autoload:set(true);
            end
        end
    end
}

configs_sec:Button{
    name = "refresh configs",
    callback = function()
        config_dropdown:Refresh(library:GetConfigs())
    end
}

configs_sec:Box{
    name = "config came",
    flag = "config_name",
    ignored = true
}

configs_sec:Button{
    name = "create config",
    callback = function()
        if library:CreateConfig(library.flags["config_name"]) and not config_dropdown:Exists(library.flags["config_name"]) then
            config_dropdown:Add(library.flags["config_name"])
            library:Notify{title = "Configuration", message = ("Successfully created config '%s'"):format(library.flags["config_name"]), duration = 5}
        end
    end
}

configs_sec:Button{
    name = "save config",
    callback = function()
        if library.flags["selected_config"] then
            if (library:SaveConfig(library.flags["selected_config"])) then
                library:Notify{title = "Configuration", message = ("Successfully saved config '%s'"):format(library.flags["selected_config"]), duration = 5}
            end
        end
    end
}

configs_sec:Button{
    name = "load config",
    callback = function()
        if (library:LoadConfig(library.flags["selected_config"])) then
            library:Notify{title = "Configuration", message = ("Successfully loaded config '%s'"):format(library.flags["selected_config"]), duration = 5}
        end
    end
}

configs_sec:Button{
    name = "delete config",
    callback = function()
        local selected = library.flags["selected_config"];
        if (selected) then
            library:DeleteConfig(selected);
            config_dropdown:Refresh(library:GetConfigs())
            library:Notify{title = "Configuration", message = ("Successfully deleted config '%s'"):format(selected), duration = 5};
        end
    end
}

autoload = configs_sec:Toggle{
    name = "autoload config",
    default = false,
    flag = "auto_load",
    callback = function(value)
        if library.initialized then
            local selected = library.flags["selected_config"];

            if (selected) then
                library:SetAutoLoadConfig(value and selected or "");

                if (value) then
                    library:Notify{title = "Configuration", message = ("Successfully set config '%s' as auto load"):format(library.flags["selected_config"])}
                end
            end
        end
    end
}

local themes_sec = settings_tab:Section({name = 'themes', side = "middle"})
local theme_colorpickers = {}
library.theme_colorpickers = theme_colorpickers;

local theme_options = {"Accent", "Window Background", "Window Border", "Black Border", "Text", "Disabled Text", "Tab Background", "Tab Border", "Section Background", "Section Border", "Object Background", "Object Border", "Dropdown Option Background"}

local theme_dropdown = themes_sec:Dropdown{
    name = "theme",
    content = library:GetThemes(),
    flag = "selected_theme",
}

themes_sec:Box{
    name = "theme name",
    flag = "theme_name",
    ignored = true
}

themes_sec:Button{
    name = "create theme",
    callback = function()
        if library:SaveTheme(library.flags["theme_name"]) and not config_dropdown:Exists(library.flags["theme_name"]) then
            theme_dropdown:Add(library.flags["theme_name"])
        end
    end
}

themes_sec:Button{
    name = "save theme",
    callback = function()
        if library.flags["selected_theme"] then
            library:Notify{title = "Theme", message = ("Successfully saved theme '%s'"):format(library.flags["selected_theme"])}
            library:SaveTheme(library.flags["selected_theme"])
        end
    end
}

themes_sec:Button{
    name = "load theme",
    callback = function()
        library:LoadTheme(library.flags["selected_theme"])
        for option, colorpicker in next, theme_colorpickers do
            colorpicker:Set(library.theme[option])
        end
    end
}

themes_sec:Button{
    name = "delete theme",
    callback = function()
        if library:DeleteTheme(library.flags["selected_theme"]) then
            theme_dropdown:Remove(library.flags["selected_theme"])
        end
    end
}

for _, option in next, theme_options do
    theme_colorpickers[option] = themes_sec:Colorpicker{
        name = option,
        default = library.theme[option],
        ignored = true,
        flag = option,
        callback = function(color)
            library:ChangeThemeOption(option, color)
        end
    }
end

local settings_sec = settings_tab:Section({name = "settings", side = 'Right'})

settings_sec:Toggle{
    name = "show keybind list",
    default = library.keybind_list_default,
    flag = "keybind_list",
    callback = function(value)
        if library.keybind_list.object.Visible ~= value then
            library.keybind_list:Toggle()
        end
    end
}

settings_sec:Toggle{
    name = "show player list",
    default = library.keybind_list_default,
    flag = "player_list",
    callback = function(value)
        library.Playerlist.toggled = value
        if library.open then
            library.Playerlist.object.Visible = value
        end
    end
}

settings_sec:Toggle{
    name = "performance drag",
    default = library.performance_drag,
    flag = "performance_drag",
    callback = function(value)
        library.performance_drag = value
    end
}

settings_sec:Keybind{
    name = "menu key",
    default = Enum.KeyCode.RightShift,
    blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    flag = "menu_key",
    listignored = true,
    callback = function(_, from_setting)
        if not from_setting then
            library:Toggle()
        end
    end
}

settings_sec:Slider{
    name = "tween speed",
    default = library.tween_speed,
    min = 0,
    max = 1,
    flag = "tween_speed",
    callback = function(value)
        library.tween_speed = value;
    end
}

settings_sec:Slider{
    name = "fade speed",
    default = library.fade_speed,
    min = 0,
    max = 1,
    flag = "fade_speed",
    callback = function(value)
        library.toggle_speed = value;
    end
}

settings_sec:Dropdown{
    name = "easing style",
    default = tostring(library.easing_style):gsub("Enum.EasingStyle.", ""),
    content = {"Linear", "Sine", "Back", "Quad", "Quart", "Quint", "Bounce", "Elastic", "Exponential", "Circular", "Cubic"},
    flag = "easing_style",
    callback = function(style)
        library.easing_style = Enum.EasingStyle[style]
    end
}

settings_sec:Button{
    name = "unload",
    callback = function()
        library:Unload();
    end
}

library:Init()
