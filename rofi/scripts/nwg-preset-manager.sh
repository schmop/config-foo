#!/bin/bash

set -euo pipefail
IFS=$'\n\t'
shopt -s nullglob


STYLE_FILE="$HOME/.config/rofi/styles/display_dialog.rasi"

PRESET_DIR="$HOME/.config/nwg-displays/presets"
ACTIVE_DISPLAY_FILE="$HOME/.config/sway/outputs"
RASI_DIR="$HOME/rofi-network-manager/rofi-network-manager.rasi"

SAVE_ACTION="> Save current display settings"

function rofi_prompt() {
    PROMPT="$1"
    WIDTH="30"
    rofi -dmenu -i -theme "$STYLE_FILE" -theme-str 'entry{placeholder:"'"$PROMPT"'";}'
}

function get_selection() {
    presets=()
    for f in "$PRESET_DIR"/*; do
        [ -f "$f" ] && presets+=("$(basename "$f")")
    done
    actions=("$SAVE_ACTION")
    options=("${presets[@]}" "${actions[@]}")

    echo -e "${options[*]}" | rofi_prompt "Select display preset..."
}

selection=$(get_selection)

if [[ "$selection" == "$SAVE_ACTION" ]]; then
    NEW_NAME=$(rofi_prompt "Enter preset filename")
    NEW_PATH="$PRESET_DIR/$NEW_NAME"
    cp "$ACTIVE_DISPLAY_FILE" "$NEW_PATH"
    exit 0
fi

selected_preset="$PRESET_DIR/$selection"
if [[ -f "$selected_preset" && -s "$selected_preset" ]]; then
    cp "$selected_preset" "$ACTIVE_DISPLAY_FILE"
    swaymsg reload > /dev/null
    exit 0
fi
echo "Could not find $selected_preset"
exit 1




