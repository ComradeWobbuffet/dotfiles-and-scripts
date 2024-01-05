#!/bin/sh

session_sounds_dir="$HOME/.session-sounds"
login_sound_dir="$session_sounds_dir/login"
logout_sound_dir="$session_sounds_dir/logout"
last_played_filename="last-played"

if [ -z "${XDG_RUNTIME_DIR}" ]; then
  last_played_dir="$session_sounds_dir"
else
  last_played_dir="$XDG_RUNTIME_DIR/.session-sounds"
fi

last_played_path="$last_played_dir/$last_played_filename"

get_random_file()
{
  ls -1 "$1" | shuf -n 1
}

mkdir -p "$last_played_dir"
if [ $? -ne 0 ]; then
  exit 1
fi


if [ "$1" = "--login" ]; then
  login_sound="$(get_random_file $login_sound_dir)"
  if [ ! -z "$login_sound" ]; then
    play "$login_sound_dir/$login_sound" &
    echo "$login_sound" > "$last_played_path"
  fi
elif [ "$1" = "--logout" ]; then
  logout_sound="$(cat $last_played_path)"
  if [ -z "$logout_sound" ]; then
    logout_sound="$(get_random_file $logout_sound_dir)"
  fi
  if [ ! -z "$logout_sound" ]; then
    play "$logout_sound_dir/$logout_sound"
  fi
else
  echo "Usage: $0 <--login|--logout>" >&2
  exit 1
fi

