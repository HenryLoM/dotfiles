#!/usr/bin/env sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/global/settings.sh"
. "$(dirname "$0")/global/icons.sh"
. "$(dirname "$0")/global/colors.sh"

# ==============================
# Battery Widget
# ==============================
sketchybar --add item battery right \
           --set battery \
                 update_freq=$settings_global_update_freq \
                 background.color=$colors_widget \
                 background.height=$settings_widget_height \
                 background.corner_radius=$settings_widget_corner_radius \
                 background.padding_left=$settings_background_padding_left \
                 background.padding_right=$settings_background_padding_right \
                 background.border_width=$settings_border_width \
                 background.border_color=$colors_border \
                 icon.padding_left=$settings_icon_padding_left \
                 icon.padding_right=$settings_icon_padding_right \
                 label.padding_left=1 \
                 label.padding_right=$settings_label_padding_right \
                 script='
                     PMSET_OUTPUT=$(pmset -g batt)
                     BATTERY_INFO=$(echo "$PMSET_OUTPUT" | tail -1)
                     PERCENT=$(echo "$BATTERY_INFO" | grep -Eo "[0-9]+%" | tr -d "%")
                     if echo "$PMSET_OUTPUT" | grep -q "AC Power"; then
                         ICON="'"$icons_battery_charging"'"
                     else
                         ICON="'"$icons_battery_idle"'"
                     fi
                     sketchybar --set battery icon="$ICON" label="${PERCENT}%"
                 ' \
            --subscribe battery system_woke power_source_change
