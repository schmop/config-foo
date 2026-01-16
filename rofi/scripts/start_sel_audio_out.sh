#!/bin/bash

dir="$HOME/.config/rofi/styles"

rofi -show "audio_out" -modi "audio_out:~/.config/rofi/scripts/sel_audio_out.sh" -i -theme "$dir/audio_dialog.rasi"
