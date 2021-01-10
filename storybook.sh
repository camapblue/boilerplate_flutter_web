#!/usr/bin/env bash

while getopts ":e:" opt; do
  case $opt in
    e) env="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ ! -z "$env" ]; then
  printf "Env now: $env"
  cp -a environments/$env/.env .env
  
  flutter run -t storybook/lib/main.dart -d chrome
else
  printf "Env now: dev"
  cp -a environments/dev/.env .env
  
  flutter run -t storybook/lib/main.dart -d chrome --enable-experiment non-nullable
fi
