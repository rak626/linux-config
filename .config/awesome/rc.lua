-- ========================================
--  AWESOME WM CONFIG (CLEAN DEV SETUP)
-- ========================================

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- ========================================
--  VARIABLES
-- ========================================
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
modkey = "Mod4"

-- ========================================
--  THEME
-- ========================================
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- ========================================
--  LAYOUTS
-- ========================================
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}

-- ========================================
--  TAGS (WORKSPACES)
-- ========================================
awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    -- TAGLIST
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
    }

    -- CLOCK
    local mytextclock = wibox.widget.textclock()

    -- TOP BAR
    s.mywibox = awful.wibar({ position = "top", screen = s })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,

        { layout = wibox.layout.fixed.horizontal,
          s.mytaglist
        },

        nil,

        { layout = wibox.layout.fixed.horizontal,
          mytextclock
        },
    }
end)

-- ========================================
--  KEYBINDINGS
-- ========================================
globalkeys = gears.table.join(

    -- TERMINAL
    awful.key({ modkey }, "Return", function ()
        awful.spawn(terminal)
    end),

    -- ROFI LAUNCHER
    awful.key({ modkey }, "d", function ()
        awful.spawn("rofi -show drun")
    end),

    -- RELOAD AWESOME
    awful.key({ modkey, "Control" }, "r", awesome.restart),

    -- QUIT AWESOME
    awful.key({ modkey, "Shift" }, "q", awesome.quit)
)

root.keys(globalkeys)

-- ========================================
--  RULES (AUTO WORKSPACE)
-- ========================================
awful.rules.rules = {

    -- FIREFOX → WORKSPACE 1
    {
        rule = { class = "Firefox" },
        properties = { screen = 1, tag = "1" }
    },

    -- TERMINAL → WORKSPACE 2
    {
        rule = { class = "Alacritty" },
        properties = { screen = 1, tag = "2" }
    },
}

-- ========================================
--  AUTOSTART
-- ========================================
awful.spawn.with_shell([[
picom &
nitrogen --restore &
nm-applet &
]])

-- START APPS
awful.spawn.with_shell("firefox")
awful.spawn.with_shell("alacritty")

-- ========================================
--  ERROR HANDLING
-- ========================================
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Startup Errors",
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Runtime Error",
            text = tostring(err)
        })
        in_error = false
    end)
end
