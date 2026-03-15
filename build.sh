#!/bin/bash
set -e

# Install Flutter SDK
git clone https://github.com/flutter/flutter.git --depth 1 --branch stable flutter-sdk
export PATH="$PATH:$(pwd)/flutter-sdk/bin"

# Build Flutter web
flutter build web --release
