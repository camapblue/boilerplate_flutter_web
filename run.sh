#!/usr/bin/env bash

while getopts ":e:d:r:" opt; do
  case $opt in
    e) env="$OPTARG"
    ;;
    d) device="$OPTARG"
    ;;
    r) release="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ ! -z "$env" ]; then
  printf "Env now: $env"
  cp -a environments/$env/.env .env

  printf "\nFinish\n"
  if [ ! -z "$device" ]; then
    printf "Device : $device"
    if [ ! -z "$release" ]; then
      printf "Release : $release"
      flutter run --flavor $env -d $device --release
    else 
      flutter run --flavor $env -d $device
    fi
  else
    if [ ! -z "$release" ]; then
      printf "Release : $release"
      flutter run --flavor $env --release
    else 
      flutter run --flavor $env
    fi
  fi
else
  flutter run --flavor dev
fi

