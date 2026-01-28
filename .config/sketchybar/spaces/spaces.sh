#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/global/settings.sh"
. "$(dirname "$0")/global/icons.sh"
. "$(dirname "$0")/global/colors.sh"

# ==============================
# Spaces
# ==============================
for i in {1..10}; do
    sketchybar --add space space.$i left \
        --set space.$i \
            associated_space=$i \
            icon="$icons_space_inactive" \
            label.drawing=off \
            background.drawing=off \
            icon.padding_left=0 \
            icon.padding_right=$settings_locked_space_padding_right \
            icon.font="$settings_fontfamily_regular:SemiBold:$settings_space_size" \
            click_script="yabai -m space --focus $i" \
            script="if [ \"\$SELECTED\" = \"true\" ]; then sketchybar --set \$NAME icon=\"$icons_space_active\"; else sketchybar --set \$NAME icon=\"$icons_space_inactive\"; fi" \
        --subscribe space.$i space_change mouse.clicked
done
