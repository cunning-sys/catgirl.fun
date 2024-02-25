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

library.playerlist:Button({
    name = 'Whitelist',
    callback = function(list, plr)
        if not list:IsTagged(plr, 'Whitelisted') then
            list:Tag({
                player = plr,
                text = 'Whitelisted',
                color = Color3.fromRGB(0, 255, 0)
            })
        else
            list:RemoveTag(plr, 'Whitelisted')
        end
    end
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
