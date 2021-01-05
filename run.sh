#!/usr/bin/env bash

while getopts ":a:e:" opt; do
  case $opt in
    a) action="$OPTARG"
    ;;
    e) env="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ ! -z "$env" ]; then
  printf "Env now: $env"
  ENV=$env make $action
else
  printf "WTF Env now: $env"
  flutter run -d chrome
fi
