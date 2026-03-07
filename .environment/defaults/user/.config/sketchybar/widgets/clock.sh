#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/global/settings.sh"
. "$(dirname "$0")/global/icons.sh"
. "$(dirname "$0")/global/colors.sh"

# ==============================
# Clock widget
# ==============================
sketchybar --add item clock right \
    --set clock \
        background.color=$colors_widget \
        background.height=$settings_widget_height \
        background.corner_radius=$settings_widget_corner_radius \
        background.padding_left=$settings_background_padding_left \
        background.padding_right=0 \
        background.border_width=$settings_border_width \
        background.border_color=$colors_border \
        icon="$icons_clock" \
        icon.padding_left=$settings_icon_padding_left \
        icon.padding_right=$settings_icon_padding_right \
        label.padding_left=$settings_label_padding_left \
        label.padding_right=$settings_label_padding_right \
        label.font="$settings_fontfamily_regular:Bold:$settings_clocklabel_size" \
        update_freq=$settings_global_update_freq \
        script="sketchybar --set \$NAME label=\"\$(date '+%d %b %I:%M %p')\""
        