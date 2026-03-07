#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/global/settings.sh"
. "$(dirname "$0")/global/icons.sh"
. "$(dirname "$0")/global/colors.sh"

# ==============================
# Source globals
# ==============================
sketchybar --bar \
    height=$settings_bar_height \
    color=$colors_bar \
    margin=$settings_bar_margin \
    padding_left=$settings_bar_padding_left \
    padding_right=$settings_bar_padding_right \
    corner_radius=$settings_bar_corner_radius \
    y_offset=$settings_bar_y_offset \
    blur_radius=$settings_bar_blur_radius \
    shadow=on \
    position=top \
    sticky=on

sketchybar --default \
    update_freq=$settings_global_update_freq \
    icon.color=$colors_icon \
    label.color=$colors_label \
    icon.font="$settings_fontfamily_regular:Bold:$settings_icon_size" \
    label.font="$settings_fontfamily_mono:Bold:$settings_label_size"