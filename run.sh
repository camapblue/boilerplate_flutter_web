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
  printf "Env now: $env\n"
  if [ ! -z "$action" ]; then
    ENV=$env make $action
  else 
    ENV=$env make run
  fi
else
  flutter run -d chrome
fi
