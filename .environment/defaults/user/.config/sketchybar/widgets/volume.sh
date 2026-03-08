#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/global/settings.sh"
. "$(dirname "$0")/global/icons.sh"
. "$(dirname "$0")/global/colors.sh"

# ==============================
# Volume widget
# ==============================
sketchybar --add item volume right \
           --set volume \
                 background.color=$colors_widget \
                 background.height=$settings_widget_height \
                 background.corner_radius=$settings_widget_corner_radius \
                 background.padding_left=$settings_background_padding_left \
                 background.padding_right=$settings_background_padding_right \
                 background.border_width=$settings_border_width \
                 background.border_color=$colors_border \
                 icon.padding_left=$settings_icon_padding_left \
                 icon.padding_right=$settings_icon_padding_right \
                 label.padding_left=$settings_label_padding_left \
                 label.padding_right=$settings_label_padding_right \
                 popup.align=center \
                 popup.background.color=$colors_widget_popup \
                 popup.background.corner_radius=$settings_widget_corner_radius \
                 popup.background.border_width=$settings_border_width \
                 popup.background.border_color=$colors_border_popup \
                 popup.background.height=$settings_widget_height \
                 update_freq=0 \
                 script="$CONFIG_DIR/helpers/volume_scripts.sh" \
           --subscribe volume volume_change
