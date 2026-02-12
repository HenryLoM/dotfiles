#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/global/settings.sh"
. "$(dirname "$0")/global/icons.sh"
. "$(dirname "$0")/global/colors.sh"

# ==============================
# Apple widget
# ==============================
sketchybar --add item apple left \
    --set apple \
        icon="$icons_apple_logo" \
        label.drawing=off \
        background.drawing=off \
        icon.padding_left=0 \
        icon.padding_right=$settings_locked_apple_padding_right \
        icon.font="$settings_fontfamily_regular:SemiBold:$settings_space_size" \
        click_script="open 'x-apple.systempreferences:com.apple.Wallpaper'"
