#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/global/settings.sh"
. "$(dirname "$0")/global/icons.sh"
. "$(dirname "$0")/global/colors.sh"

# ==============================
# Trash Widget
# ==============================
sketchybar --add item trash right \
    --set trash \
        background.color=$colors_widget \
        background.height=$settings_widget_height \
        background.corner_radius=$settings_widget_corner_radius \
        background.padding_left=$settings_background_padding_left \
        background.padding_right=$((settings_background_padding_right + 3)) \
        background.border_width=$settings_border_width \
        background.border_color=$colors_border \
        icon=$icons_trash_idle \
        icon.padding_left=$settings_icon_padding_left \
        icon.padding_right=$settings_icon_padding_left \
        click_script="$CONFIG_DIR/helpers/trash_scripts.sh" \
