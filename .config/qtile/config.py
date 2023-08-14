import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from themes.obsidian import *

mod = "mod4"
terminal = "alacritty"

@hook.subscribe.startup_once
def autostart_once():
    # Programs or commands to be executed at the first startup
    programs = [
        "nm-applet &", # network manager
        "insync start &", # start onedrive
        "pasystray -m 100 -i 2 --key-grabbing &" # volume tray
        "nitrogen --restore", # set backrgound image
    ]
    for program in programs:
        subprocess.Popen(program, shell=True)

@hook.subscribe.startup
def autostart_always():
    # Programs or commands to be executed each time qtile is loaded
    programs = [
        "picom -b",
        # "xinput --set-prop 11 'libinput Accel Profile Enabled' 0, 1",
    ]
    for program in programs:
        subprocess.Popen(program, shell=True)

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html

    # Launch rofi
    Key([mod], "d", lazy.spawn(".config/rofi/scripts/launcher_t1")),

    # Launch powermenu
    Key([mod, "shift"], "p", lazy.spawn(".config/rofi/scripts/powermenu_t4")),

    # Screenshots with flameshot
    Key([], "Print", lazy.spawn("flameshot gui --path Pictures/Screenshots")),
    Key(["control"], "Print", lazy.spawn("flameshot full --path Pictures/Screenshots")),

    # Switch windows focus
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    # Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    # Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    # Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    # Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"), 
    Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
]

# Groups
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_layouts = ["max", "stack", "monadtall", "max", "max", "max", "max", "max", "stack"]

# Append groups to the groups list
for i in range(len(group_names)):
    groups.append(
        Group(
            name = group_names[i],
            layout = group_layouts[i],
            label = group_labels[i]
        )
    )
# Groups keybindings
for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

# Append ScratchPads to the groups list
groups.append(ScratchPad("scratchpad", [
    DropDown("term", "alacritty --class=ScratchAlacritty", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost_hide=True),
]))
# Scratchpad keybindings
keys.extend([
    Key([mod], "backslash", lazy.group["scratchpad"].dropdown_toggle("term")),
])

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=1, border_width=3, margin=6, border_focus=blue, border_normal=background),
    layout.MonadTall(border_width=3, margin=4, border_focus=blue, border_normal=background),
]

widget_defaults = dict(
    font = "JetBrainsMono NF Medium",
    fontsize = 18,
    padding = 3,
    foreground =foreground,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen (
        bottom = bar.Bar(
            [   
                widget.GroupBox(
                    borderwidth = 4,
                    active = foreground,
                    inactive = inactive,
                    highlight_method = "line",
                    highlight_color = background,
                    this_current_screen_border = blue,
                    disable_drag = True,
                    hide_unused=False,
                    margin_x=0,
                    padding=3,
                ),

                # Task List
                widget.TaskList(
                    icon_size = 0,
                    border = focused,
                    unfocused_border = unfocused,
                    rounded = False,
                    margin = 0,
                    padding = 4,
                    highlight_method="block",
                    title_width_method = "uniform",
                    txt_floating = "🗗 ",
                    txt_maximized = "🗖 ",
                    txt_minimized = "🗕 ",
                ),
                widget.Sep(linewidth = 0, padding = 10),

                # Date
                widget.Clock(format="%A, %b %-d"),
                widget.Sep(linewidth = 0, padding = 15),

                # Time
                widget.Clock(markup=True, format="<span foreground='#FFFFFF'>󰥔 </span>%I:%M %p"),
                widget.Sep(linewidth=0, padding = 15),

                # Battery
                widget.Battery(show_short_text=False, foreground="#FFFFFF", format="{char}", full_char=" ", charge_char=" ", discharge_char = ' ', update_interval=5),
                widget.Battery(show_short_text=False, format="{percent:2.0%}", notify_below = 30, notification_timeout = 0, update_interval=5),
                widget.Battery(show_short_text=False, format="{char}", full_char="", charge_char="󰁞", discharge_char = '󰁆', update_interval=5),
                widget.Sep(linewidth = 0, padding = 15),

                widget.WidgetBox(
                    widgets=[widget.Systray(icon_size=22)],
                    foreground=yellow,
                    text_closed=" ",
                    text_open="  ",
                    close_button_location="right"
                ),
                widget.Sep(linewidth = 0, padding = 15),
                
                # Layout icon
                widget.CurrentLayoutIcon(scale = 0.6, background=blue),
            ],
            size = 34,
            background = background,
            opacity=1.0,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width = 2,
    border_focus = blue,
    border_normal = background,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="pavucontrol"),
        Match(wm_class="blueman-manager"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

