#!/usr/bin/env sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/global/settings.sh"
. "$(dirname "$0")/global/icons.sh"
. "$(dirname "$0")/global/colors.sh"

# ==============================
# Clipboard Widget
# ==============================
sketchybar --add item clipboard right \
           --set clipboard \
                 background.color=$colors_widget \
                 background.height=$settings_widget_height \
                 background.corner_radius=$settings_widget_corner_radius \
                 background.padding_left=$settings_background_padding_left \
                 background.padding_right=$settings_background_padding_right \
                 background.border_width=$settings_border_width \
                 background.border_color=$colors_border \
                 icon=$icons_clipboard \
                 icon.padding_left=$settings_icon_padding_left \
                 icon.padding_right=$settings_icon_padding_left \
                 click_script="open -a \"Maccy\""
