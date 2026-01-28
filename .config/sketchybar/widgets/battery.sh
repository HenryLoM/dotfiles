#!/bin/sh

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
                 background.color=$colors_widget \
                 background.height=$settings_widget_height \
                 background.corner_radius=$settings_widget_corner_radius \
                 background.padding_left=$settings_background_padding_left \
                 background.padding_right=$settings_background_padding_right \
                 background.border_width=$settings_border_width \
                 background.border_color=$colors_border \
                 update_freq=$settings_global_update_freq \
                 icon.padding_left=$settings_icon_padding_left \
                 icon.padding_right=$settings_icon_padding_right \
                 label.padding_left=$settings_label_padding_left \
                 label.padding_right=$settings_label_padding_right \
                 popup.align=center \
                 popup.background.color=$colors_widget \
                 popup.background.corner_radius=$settings_widget_corner_radius \
                 popup.background.border_width=$settings_border_width \
                 popup.background.border_color=$colors_border \
                 popup.background.height=$settings_widget_height \
                 script="$CONFIG_DIR/helpers/battery_scripts.sh update" \
                 click_script="$CONFIG_DIR/helpers/battery_scripts.sh click" \
           --subscribe battery power_source_change system_woke mouse.clicked

# ==============================
# Popup Item: Remaining Time
# ==============================
sketchybar --add item battery.popup popup.battery \
           --set battery.popup \
                 background.drawing=off \
                 icon="Time remaining:" \
                 icon.align=left \
                 icon.padding_left=$settings_icon_padding_left \
                 icon.padding_right=$settings_icon_padding_right \
                 label.padding_left=$settings_label_padding_left \
                 label.padding_right=$settings_label_padding_right \
                 label="??:??h" \
                 label.align=right \
                 icon.font="$settings_fontfamily_regular:Bold:$settings_label_size"
