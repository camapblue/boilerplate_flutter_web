#!/usr/bin/env bash

flutter build apk
cp -r ./build/app/intermediates/flutter/release/flutter_assets/fonts/MaterialIcons-Regular.otf ./assets/fonts/MaterialIcons-Regular.otf